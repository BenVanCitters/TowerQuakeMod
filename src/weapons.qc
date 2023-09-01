/*  Copyright (C) 1996-2022 id Software LLC

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

    See file, 'COPYING', for details.
*/

void (entity targ, entity inflictor, entity attacker, float damage) T_Damage;
void () player_run;
void(entity bomb, entity attacker, float rad, entity ignore) T_RadiusDamage;
void(vector org, vector vel, float damage) SpawnBlood;
void() SuperDamageSound;


// called by worldspawn
void() W_Precache =
{
	precache_sound ("weapons/r_exp3.wav");	// new rocket explosion
	precache_sound ("weapons/rocket1i.wav");	// spike gun
	precache_sound ("weapons/sgun1.wav");
	precache_sound ("weapons/guncock.wav");	// player shotgun
	precache_sound ("weapons/ric1.wav");	// ricochet (used in c code)
	precache_sound ("weapons/ric2.wav");	// ricochet (used in c code)
	precache_sound ("weapons/ric3.wav");	// ricochet (used in c code)
	precache_sound ("weapons/spike2.wav");	// super spikes
	precache_sound ("weapons/tink1.wav");	// spikes tink (used in c code)
	precache_sound ("weapons/grenade.wav");	// grenade launcher
	precache_sound ("weapons/bounce.wav");		// grenade bounce
	precache_sound ("weapons/shotgn2.wav");	// super shotgun
};

float() crandom =
{
	return 2*(random() - 0.5);
};



/*
================
W_FireAxe
================
*/
void() W_FireAxe =
{
	local	vector	source;
	local	vector	org;

	makevectors (self.v_angle);
	source = self.origin + '0 0 16';
	traceline (source, source + v_forward*64, FALSE, self);

	local float validRangeToHurtOrUpgrade = trace_ent.takedamage != DAMAGE_NO;
	org = trace_endpos - v_forward*4;
	local entity upgradeOrInjureEnt = trace_ent;
	
	local vector end = source + v_forward*200;
	traceline (source, end, FALSE, self);
	
	
	local vector spawnPos = getSpawnPosForSelf();
	local float traceDist = vlen(source - spawnPos);
			
	// 80 is approx the length of the diagonal of a tower bounding box
	//closer than than and the player and tower may be inside each other
	local float minPlacementDist = 60; 
	
	local float validRangeToDropTower = (trace_fraction < 1.0 && traceDist > minPlacementDist );
	
	if(!self.isDroppingTower)
	{
		if (upgradeOrInjureEnt.takedamage && upgradeOrInjureEnt.tower_owner == self)
		{
			upgradeOrInjureEnt.tower_upgrade_points += 1; 
			tower_checkUpgrade(upgradeOrInjureEnt);
			sound (self, CHAN_WEAPON, "items/armor1.wav", 1, ATTN_NORM);
		}
		else if (upgradeOrInjureEnt.takedamage)
		{
			upgradeOrInjureEnt.axhitme = 1;
			SpawnBlood (org, '0 0 0', 20);
			T_Damage (upgradeOrInjureEnt, self, self, 20);
		}
	}
	else
	{	
		
		

		if (validRangeToDropTower ) 
		{

			monster_tow_army( spawnPos , self );
		
			sound (self, CHAN_WEAPON, "player/axhit2.wav", 1, ATTN_NORM);
			//stuffcmd (self, "vibrate tactile/player/axhit2.bnvib");
			WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
			WriteByte (MSG_BROADCAST, TE_GUNSHOT);
			WriteCoord (MSG_BROADCAST, org_x);
			WriteCoord (MSG_BROADCAST, org_y);
			WriteCoord (MSG_BROADCAST, org_z);
		}
		
	}
};


//============================================================================


vector() wall_velocity =
{
	local vector	vel;
	
	vel = normalize (self.velocity);
	vel = normalize(vel + v_up*(random()- 0.5) + v_right*(random()- 0.5));
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;
	
	return vel;
};


/*
================
SpawnMeatSpray
================
*/
void(vector org, vector vel) SpawnMeatSpray =
{
	local	entity missile;

	missile = spawn ();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_NOT;

	makevectorsfixed(self.angles);

	missile.velocity = vel;
	missile.velocity_z = missile.velocity_z + 250 + 50*random();

	missile.avelocity = '3000 1000 2000';
	
	// set missile duration
	missile.nextthink = time + 1;
	missile.think = SUB_Remove;

	setmodel (missile, "progs/zom_gib.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
	setorigin (missile, org);
};

/*
================
SpawnBlood
================
*/
void(vector org, vector vel, float damage) SpawnBlood =
{
	particle (org, vel*0.1, 73, damage*2);
};

/*
================
spawn_touchblood
================
*/
void(float damage) spawn_touchblood =
{
	local vector	vel;

	vel = wall_velocity () * 0.2;
	SpawnBlood (self.origin + vel*0.01, vel, damage);
};

/*
==============================================================================

MULTI-DAMAGE

Collects multiple small damages into a single damage

==============================================================================
*/

entity	multi_ent;
float	multi_damage;

void() ClearMultiDamage =
{
	multi_ent = world;
	multi_damage = 0;
};

void() ApplyMultiDamage =
{
	if (!multi_ent)
		return;

	T_Damage (multi_ent, self, self, multi_damage);
};

void(entity hit, float damage) AddMultiDamage =
{
	if (!hit)
		return;
	
	if (hit != multi_ent)
	{
		ApplyMultiDamage ();
		multi_damage = damage;
		multi_ent = hit;
	}
	else
		multi_damage = multi_damage + damage;
};

/*
==============================================================================

BULLETS

==============================================================================
*/

/*
================
TraceAttack
================
*/
void(float damage, vector dir) TraceAttack =
{
	local	vector	vel, org;
	
	vel = normalize(dir + v_up*crandom() + v_right*crandom());
	vel = vel + 2*trace_plane_normal;
	vel = vel * 200;

	org = trace_endpos - dir*4;

	if (trace_ent.takedamage)
	{
		SpawnBlood (org, vel*0.2, damage);
		AddMultiDamage (trace_ent, damage);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
};

/*
================
FireBullets

Used by shotgun, super shotgun, and enemy soldier firing
Go to the trouble of combining multiple pellets into a single damage call.
================
*/
void(float shotcount, vector dir, vector spread) FireBullets =
{
	local	vector direction;
	local	vector	src;
	
	makevectors(self.v_angle);

	src = self.origin + v_forward*10;
	src_z = self.absmin_z + self.size_z * 0.7;

	ClearMultiDamage ();
	while (shotcount > 0)
	{
		direction = dir + crandom()*spread_x*v_right + crandom()*spread_y*v_up;

		traceline (src, src + direction*2048, FALSE, self);
		if (trace_fraction != 1.0)
			TraceAttack (4, direction);

		shotcount = shotcount - 1;
	}
	ApplyMultiDamage ();
};



/*
==============================================================================

ROCKETS

==============================================================================
*/

void()	s_explode1	=	[0,		s_explode2] {};
void()	s_explode2	=	[1,		s_explode3] {};
void()	s_explode3	=	[2,		s_explode4] {};
void()	s_explode4	=	[3,		s_explode5] {};
void()	s_explode5	=	[4,		s_explode6] {};
void()	s_explode6	=	[5,		SUB_Remove] {};

void() BecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

void() T_MissileTouch =
{
	local float	damg;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

	damg = 100 + random()*20;
	
	if (other.health)
	{
		if (other.classname == "monster_shambler")
			damg = damg * 0.5;	// mostly immune
		T_Damage (other, self, self.owner, damg );
	}

	// don't do radius damage to the other, because all the damage
	// was done in the impact
	T_RadiusDamage (self, self.owner, 120, other);

	self.origin = self.origin - 8*normalize(self.velocity);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};


/*
===============================================================================

LIGHTNING

===============================================================================
*/

/*
=================
LightningDamage
=================
*/
void(vector p1, vector p2, entity from, float damage) LightningDamage =
{
	local entity		e1, e2;
	local vector		f;
	
	f = p2 - p1;
	normalize (f);
	f_x = 0 - f_y;
	f_y = f_x;
	f_z = 0;
	f = f*16;

	e1 = e2 = world;

	traceline (p1, p2, FALSE, self);
	if (trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
		T_Damage (trace_ent, from, from, damage);
		if (self.classname == "player")
		{
			if (other.classname == "player")
				trace_ent.velocity_z = trace_ent.velocity_z + 400;
		}
	}

	e1 = trace_ent;

	traceline (p1 + f, p2 + f, FALSE, self);
	if (trace_ent != e1 && trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
		T_Damage (trace_ent, from, from, damage);
	}

	e2 = trace_ent;

	traceline (p1 - f, p2 - f, FALSE, self);
	if (trace_ent != e1 && trace_ent != e2 && trace_ent.takedamage)
	{
		particle (trace_endpos, '0 0 100', 225, damage*4);
		T_Damage (trace_ent, from, from, damage);
	}
};


void() W_FireLightning =
{

};


void() spike_touch;
void() superspike_touch;


/*
===============
launch_spike

Used for both the player and the ogre
===============
*/
void(vector org, vector dir) launch_spike =
{
	newmis = spawn ();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;

	newmis.angles = vectoangles(dir);
	
	newmis.touch = spike_touch;
	newmis.classname = "spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = time + 6;
	setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	setorigin (newmis, org);

	newmis.velocity = dir * 1000;
};

void() W_FireSuperSpikes =
{

};

void(float ox) W_FireSpikes =
{

};

void() spike_touch =
{
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (9);
		T_Damage (other, self, self.owner, 9);
	}

	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		
		if (self.classname == "wizard_spike")
			WriteByte (MSG_BROADCAST, TE_WIZSPIKE);

		else if (self.classname == "knight_spike")
			WriteByte (MSG_BROADCAST, TE_KNIGHTSPIKE);
		else
			WriteByte (MSG_BROADCAST, TE_SPIKE);

		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}

	remove(self);

};

void() superspike_touch =
{
	if (other == self.owner)
		return;

	if (other.solid == SOLID_TRIGGER)
		return;	// trigger field, do nothing

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	// hit something that bleeds
	if (other.takedamage)
	{
		spawn_touchblood (18);
		T_Damage (other, self, self.owner, 18);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_SUPERSPIKE);
		WriteCoord (MSG_BROADCAST, self.origin_x);
		WriteCoord (MSG_BROADCAST, self.origin_y);
		WriteCoord (MSG_BROADCAST, self.origin_z);
	}

	remove(self);

};


/*
===============================================================================

PLAYER WEAPON USE

===============================================================================
*/

void() W_SetCurrentAmmo =
{
	player_run ();		// get out of any weapon firing states
	self.weaponframe = 0;

	self.items = self.items - ( self.items & (IT_SHELLS | IT_NAILS | IT_ROCKETS | IT_CELLS) );

	self.currentammo = 0;
	self.weaponmodel = "progs/v_axe.mdl";
	
};

float() W_BestWeapon =
{
	return IT_AXE;
};

float(entity playerEnt, float old, float new) W_WantsToChangeWeapon =
{
	float playerFlags = CheckPlayerEXFlags(playerEnt);
	if((playerFlags & PEF_CHANGENEVER) != 0)
	{
		return 0;
	}
	
	if(((playerFlags & PEF_CHANGEONLYNEW) != 0) && old == new)
	{
		return 0;
	}

	return 1;
};

float() W_HasNoAmmo =
{
	if (self.currentammo)
		return FALSE;

	if (self.weapon == IT_AXE)
		return FALSE;	// doesnt need ammo
	
	self.weapon = W_BestWeapon ();

	W_SetCurrentAmmo ();
	
	// drop the weapon down
	return TRUE;
};

/*
============
W_Attack

An attack impulse can be triggered now
============
*/
void()	player_axe1;
void()	player_axeb1;
void()	player_axec1;
void()	player_axed1;
void()	player_shot1;
void()	player_nail1;
void()	player_light1;
void()	player_rocket1;

void() W_Attack_old =
{
	local	float	r;

	if ( W_HasNoAmmo() ) {
		return;
	}
	
	makevectors	(self.v_angle);		// calculate forward angle for velocity
	self.show_hostile = time + 1;	// wake monsters up
	
	// [NDS] haleyjd: record player attacked
	if (self.weapon != IT_AXE)
	{
		self.fired_weapon = 1;
	}

	if (self.weapon == IT_AXE)
	{
		sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
		//stuffcmd (self, "vibrate tactile/weapons/ax1.bnvib");
		r = random();
		if (r < 0.25)
			player_axe1 ();
		else if (r<0.5)
			player_axeb1 ();
		else if (r<0.75)
			player_axec1 ();
		else
			player_axed1 ();
		self.attack_finished = time + 0.5;
	}
};

void() W_Attack =
{
	local	float	r;

	if ( W_HasNoAmmo() ) {
		return;
	}
	
	makevectors	(self.v_angle);		// calculate forward angle for velocity
	self.show_hostile = time + 1;	// wake monsters up
	
	// [NDS] haleyjd: record player attacked
	if (self.weapon != IT_AXE)
	{
		self.fired_weapon = 1;
	}

	if (self.weapon == IT_AXE)
	{
		sound (self, CHAN_WEAPON, "weapons/ax1.wav", 1, ATTN_NORM);
		//stuffcmd (self, "vibrate tactile/weapons/ax1.bnvib");
		r = random();
		if (r < 0.25)
			player_axe1 ();
		else if (r<0.5)
			player_axeb1 ();
		else if (r<0.75)
			player_axec1 ();
		else
			player_axed1 ();
		self.attack_finished = time + 0.5;
	}
};

/*
============
W_ChangeWeapon

============
*/
void() W_ChangeWeapon =
{
// set weapon, set ammo
//
	self.weapon = IT_AXE;		
	W_SetCurrentAmmo ();
};

/*
============
CheatCommand
============
*/
void CheatCommand() {

	if ( ( deathmatch || coop ) && cheats_allowed == 0 ) { // mal: allow impulse 9 IF cheats allowed
		return;
	}

	self.ammo_rockets = 0;
	self.ammo_nails = 0;
	self.ammo_shells = 0;
	self.items = self.items | 
		IT_AXE |
		IT_KEY1 | IT_KEY2;

	self.ammo_cells = 0;
	
	// mal: also give full armor...
	self.armortype = 0.8;
	self.armorvalue = 200;
	self.items = self.items - ( self.items & ( IT_ARMOR1 | IT_ARMOR2 | IT_ARMOR3 ) ) + IT_ARMOR3;

	self.weapon = IT_AXE;
	self.impulse = 0;
	W_SetCurrentAmmo ();
};

/*
============
CycleWeaponCommand

Go to the next weapon with ammo
============
*/
void() CycleWeaponCommand =
{

	self.impulse = 0;
	
	self.weapon = IT_AXE;
	W_SetCurrentAmmo ();
};


/*
============
CycleWeaponReverseCommand

Go to the prev weapon with ammo
============
*/
void() CycleWeaponReverseCommand =
{
	self.impulse = 0;

	self.weapon = IT_AXE;
	W_SetCurrentAmmo ();

};

/*
============
ServerflagsCommand

Just for development
============
*/
void() ServerflagsCommand =
{
	serverflags = serverflags * 2 + 1;
};

void() QuadCheat =
{
	if (!cheats_allowed)
		return;

	self.super_time = 1;
	self.super_damage_finished = time + 30;
	self.items = self.items | IT_QUAD;
	dprint ("quad cheat\n");
};

/*
============
ImpulseCommands

============
*/
void() ImpulseCommands =
{
	if (self.impulse >= 1 && self.impulse <= 8)
		W_ChangeWeapon ();
	if (self.impulse == 9)
		CheatCommand ();
	if (self.impulse == 10)
		CycleWeaponCommand ();
	if (self.impulse == 11)
		ServerflagsCommand ();
	if (self.impulse == 12)
		CycleWeaponReverseCommand();
	if (self.impulse == 255)
		QuadCheat ();
		
	self.impulse = 0;
};

void() W_WeaponFrame =
{
	local float previousAttackFinished = time >= self.attack_finished ;
	//if you are pressing fire button
	if ( self.button0 ) 
	{
		//if the 
		if(self.button0DownStart > 0)
		{
			//held down button
			if(time - self.button0DownStart > .2)
			{		
				if ( previousAttackFinished ) 
				{
					drawTowerUnderReticule();
				}
			}
		}
		else
		{
			self.button0DownStart = time;
		}
	}
	else //release
	{
		if(self.button0DownStart > 0)
		{
			if ( previousAttackFinished ) 
			{
				self.isDroppingTower = (time - self.button0DownStart > .2);
				
				SuperDamageSound ();
				W_Attack ();					
			}
		}
		hideReticuleTower();
		//relased the button so reset the start time
		self.button0DownStart = -1;
	}


	if (self.impulse)
		ImpulseCommands ();
	
};

/*
============
W_WeaponFrame

Called every frame so impulse events can be handled as well as possible
============
*/
void() W_WeaponFrame_old =
{
	
	//drawTowerUnderReticule();
	if ( time < self.attack_finished ) {
		return;
	}

	if (self.impulse)
		ImpulseCommands ();
	
	// check for attack
	if ( self.button0 ) {
		SuperDamageSound ();
		W_Attack ();
	}
};

/*
========
SuperDamageSound

Plays sound if needed
========
*/
void() SuperDamageSound =
{
	if (self.super_damage_finished > time)
	{
		if (self.super_sound < time)
		{
			self.super_sound = time + 1;
			sound (self, CHAN_BODY, "items/damage3.wav", 1, ATTN_NORM);
		}
	}
	return;
};
