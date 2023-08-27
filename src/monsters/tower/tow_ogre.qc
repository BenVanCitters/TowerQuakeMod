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

/* 
==============================================================================

tow_ogre

==============================================================================
*/

$cd id1/models/ogre_c
$origin 0 0 24
$base base		
$skin base

$frame	stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7
$frame walk8 walk9 walk10 walk11 walk12 walk13 walk14 walk15 walk16

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame swing1 swing2 swing3 swing4 swing5 swing6 swing7
$frame swing8 swing9 swing10 swing11 swing12 swing13 swing14

$frame smash1 smash2 smash3 smash4 smash5 smash6 smash7
$frame smash8 smash9 smash10 smash11 smash12 smash13 smash14

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6

$frame pain1 pain2 pain3 pain4 pain5

$frame painb1 painb2 painb3

$frame painc1 painc2 painc3 painc4 painc5 painc6

$frame paind1 paind2 paind3 paind4 paind5 paind6 paind7 paind8 paind9 paind10
$frame paind11 paind12 paind13 paind14 paind15 paind16

$frame paine1 paine2 paine3 paine4 paine5 paine6 paine7 paine8 paine9 paine10
$frame paine11 paine12 paine13 paine14 paine15

$frame death1 death2 death3 death4 death5 death6
$frame death7 death8 death9 death10 death11 death12
$frame death13 death14

$frame bdeath1 bdeath2 bdeath3 bdeath4 bdeath5 bdeath6
$frame bdeath7 bdeath8 bdeath9 bdeath10

$frame pull1 pull2 pull3 pull4 pull5 pull6 pull7 pull8 pull9 pull10 pull11

//=============================================================================


void() tow_ogreGrenadeExplode =
{
	T_RadiusDamage (self, self.owner, 40, world);
	sound (self, CHAN_VOICE, "weapons/r_exp3.wav", 1, ATTN_NORM);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

void() tow_ogreGrenadeTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner

	if (other.takedamage == DAMAGE_AIM)
	{
		tow_ogreGrenadeExplode();
		return;
	}

	sound (self, CHAN_VOICE, "weapons/bounce.wav", 1, ATTN_NORM);	// bounce sound

	if (self.velocity == '0 0 0')
		self.avelocity = '0 0 0';
};

/*
================
tow_ogreFireGrenade
================
*/
void() tow_ogreFireGrenade =
{
	local	entity missile;
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	missile = spawn ();
	missile.classname = "tow_ogre_grenade";
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
		
// set missile speed	

	makevectorsfixed(self.angles);

	missile.velocity = normalize(self.enemy.origin - self.origin);
	missile.velocity = missile.velocity * 600;
	missile.velocity_z = 200;

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = tow_ogreGrenadeTouch;

	if (cvar("pr_checkextension"))
		if (checkextension("EX_EXTENDED_EF"))
			missile.effects = missile.effects | EF_CANDLELIGHT; // give the projectiles a weak glow
	
// set missile duration
	missile.nextthink = time + 2.5;
	missile.think = tow_ogreGrenadeExplode;

	setmodel (missile, "progs/grenade.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
	setorigin (missile, self.origin);
};


//=============================================================================




void() tow_ogre_stand1	=[	$stand1,	tow_ogre_stand2	] {FindTowerTarget();};
void() tow_ogre_stand2	=[	$stand2,	tow_ogre_stand3	] {FindTowerTarget();};
void() tow_ogre_stand3	=[	$stand3,	tow_ogre_stand4	] {FindTowerTarget();};
void() tow_ogre_stand4	=[	$stand4,	tow_ogre_stand5	] {FindTowerTarget();};
void() tow_ogre_stand5	=[	$stand5,	tow_ogre_stand6	] {
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "ogre/ogidle.wav", 1, ATTN_IDLE);

	FindTowerTarget();
};

void() tow_ogre_stand6	=[	$stand6,	tow_ogre_stand7	] {FindTowerTarget();};
void() tow_ogre_stand7	=[	$stand7,	tow_ogre_stand8	] {FindTowerTarget();};
void() tow_ogre_stand8	=[	$stand8,	tow_ogre_stand9	] {FindTowerTarget();};
void() tow_ogre_stand9	=[	$stand9,	tow_ogre_stand1	] {FindTowerTarget();};

void() tow_ogre_walk1	=[	$walk1,		tow_ogre_walk2	] {};
void() tow_ogre_walk2	=[	$walk2,		tow_ogre_walk3	] {};
void() tow_ogre_walk3	=[	$walk3,		tow_ogre_walk4	] {

	if (random() < 0.2)
		sound (self, CHAN_VOICE, "ogre/ogidle.wav", 1, ATTN_IDLE);
};

void() tow_ogre_walk4	=[	$walk4,		tow_ogre_walk5	] {};
void() tow_ogre_walk5	=[	$walk5,		tow_ogre_walk6	] {};
void() tow_ogre_walk6	=[	$walk6,		tow_ogre_walk7	] {

	if (random() < 0.1)
		sound (self, CHAN_VOICE, "ogre/ogdrag.wav", 1, ATTN_IDLE);
};

void() tow_ogre_walk7	=[	$walk7,		tow_ogre_walk8	] {};
void() tow_ogre_walk8	=[	$walk8,		tow_ogre_walk9	] {};
void() tow_ogre_walk9	=[	$walk9,		tow_ogre_walk10	] {};
void() tow_ogre_walk10	=[	$walk10,	tow_ogre_walk11	] {};
void() tow_ogre_walk11	=[	$walk11,	tow_ogre_walk12	] {};
void() tow_ogre_walk12	=[	$walk12,	tow_ogre_walk13	] {};
void() tow_ogre_walk13	=[	$walk13,	tow_ogre_walk14	] {};
void() tow_ogre_walk14	=[	$walk14,	tow_ogre_walk15	] {};
void() tow_ogre_walk15	=[	$walk15,	tow_ogre_walk16	] {};
void() tow_ogre_walk16	=[	$walk16,	tow_ogre_walk1	] {};

void() tow_ogre_run1	=[	$run1,		tow_ogre_run2	] {
	

	if (random() < 0.2)
		sound (self, CHAN_VOICE, "ogre/ogidle2.wav", 1, ATTN_IDLE);
};

void() tow_ogre_run2	=[	$run2,		tow_ogre_run3	] {};
void() tow_ogre_run3	=[	$run3,		tow_ogre_run4	] {};
void() tow_ogre_run4	=[	$run4,		tow_ogre_run5	] {};
void() tow_ogre_run5	=[	$run5,		tow_ogre_run6	] {};
void() tow_ogre_run6	=[	$run6,		tow_ogre_run7	] {};
void() tow_ogre_run7	=[	$run7,		tow_ogre_run8	] {};
void() tow_ogre_run8	=[	$run8,		tow_ogre_stand1	] {};

void() tow_ogre_swing1	=[	$swing1,		tow_ogre_swing2	] {
sound (self, CHAN_WEAPON, "ogre/ogsawatk.wav", 1, ATTN_NORM);};
void() tow_ogre_swing2	=[	$swing2,		tow_ogre_swing3	] {};
void() tow_ogre_swing3	=[	$swing3,		tow_ogre_swing4	] {};
void() tow_ogre_swing4	=[	$swing4,		tow_ogre_swing5	] {};
void() tow_ogre_swing5	=[	$swing5,		tow_ogre_swing6	] {

	chainsaw(0);
	self.angles_y = self.angles_y + random() * 25;
};

void() tow_ogre_swing6	=[	$swing6,		tow_ogre_swing7	] {
	chainsaw(200);
	self.angles_y = self.angles_y + random()* 25;
};

void() tow_ogre_swing7	=[	$swing7,		tow_ogre_swing8	] {
	chainsaw(0);
	self.angles_y = self.angles_y + random() * 25;
};

void() tow_ogre_swing8	=[	$swing8,		tow_ogre_swing9	] {
	chainsaw(0);
	self.angles_y = self.angles_y + random() * 25;
};

void() tow_ogre_swing9	=[	$swing9,		tow_ogre_swing10 ] {
	chainsaw(0);
	self.angles_y = self.angles_y + random() * 25;
};

void() tow_ogre_swing10	=[	$swing10,		tow_ogre_swing11 ] {
	chainsaw(-200);
	self.angles_y = self.angles_y + random() * 25;
};

void() tow_ogre_swing11	=[	$swing11,		tow_ogre_swing12 ] {
	chainsaw(0);
	self.angles_y = self.angles_y + random() * 25;
};

void() tow_ogre_swing12	=[	$swing12,		tow_ogre_swing13 ] {};
void() tow_ogre_swing13	=[	$swing13,		tow_ogre_swing14 ] {};
void() tow_ogre_swing14	=[	$swing14,		tow_ogre_stand1	]  {};

void() tow_ogre_smash1	=[	$smash1,		tow_ogre_smash2	] {
sound (self, CHAN_WEAPON, "ogre/ogsawatk.wav", 1, ATTN_NORM);
};
void() tow_ogre_smash2	=[	$smash2,		tow_ogre_smash3	] {};
void() tow_ogre_smash3	=[	$smash3,		tow_ogre_smash4	] {};
void() tow_ogre_smash4	=[	$smash4,		tow_ogre_smash5	] {};
void() tow_ogre_smash5	=[	$smash5,		tow_ogre_smash6	] {};
void() tow_ogre_smash6	=[	$smash6,		tow_ogre_smash7	] { chainsaw(0);};
void() tow_ogre_smash7	=[	$smash7,		tow_ogre_smash8	] { chainsaw(0);};
void() tow_ogre_smash8	=[	$smash8,		tow_ogre_smash9	] { chainsaw(0);};
void() tow_ogre_smash9	=[	$smash9,		tow_ogre_smash10 ] { chainsaw(0);};
void() tow_ogre_smash10	=[	$smash10,		tow_ogre_smash11 ] {chainsaw(1);};
void() tow_ogre_smash11	=[	$smash11,		tow_ogre_smash12 ] {
	 
	chainsaw(0);
	self.nextthink = self.nextthink + random() * 0.2;
};	// slight variation

void() tow_ogre_smash12	=[	$smash12,		tow_ogre_smash13 ] {};
void() tow_ogre_smash13	=[	$smash13,		tow_ogre_smash14 ] {};
void() tow_ogre_smash14	=[	$smash14,		tow_ogre_stand1	]  {};

void() tow_ogre_nail1	=[	$shoot1,		tow_ogre_nail2	] {ai_face();};
void() tow_ogre_nail2	=[	$shoot2,		tow_ogre_nail3	] {ai_face();};
void() tow_ogre_nail3	=[	$shoot2,		tow_ogre_nail4	] {ai_face();};
void() tow_ogre_nail4	=[	$shoot3,		tow_ogre_nail5	] {ai_face();tow_ogreFireGrenade();};
void() tow_ogre_nail5	=[	$shoot4,		tow_ogre_nail6	] {ai_face();};
void() tow_ogre_nail6	=[	$shoot5,		tow_ogre_nail7	] {ai_face();};
void() tow_ogre_nail7	=[	$shoot6,		tow_ogre_stand1	] {ai_face();};

void()	tow_ogre_pain1	=[	$pain1,		tow_ogre_pain2	] {};
void()	tow_ogre_pain2	=[	$pain2,		tow_ogre_pain3	] {};
void()	tow_ogre_pain3	=[	$pain3,		tow_ogre_pain4	] {};
void()	tow_ogre_pain4	=[	$pain4,		tow_ogre_pain5	] {};
void()	tow_ogre_pain5	=[	$pain5,		tow_ogre_stand1	] {};


void()	tow_ogre_painb1	=[	$painb1,	tow_ogre_painb2	] {};
void()	tow_ogre_painb2	=[	$painb2,	tow_ogre_painb3	] {};
void()	tow_ogre_painb3	=[	$painb3,	tow_ogre_stand1	] {};


void()	tow_ogre_painc1	=[	$painc1,	tow_ogre_painc2	] {};
void()	tow_ogre_painc2	=[	$painc2,	tow_ogre_painc3	] {};
void()	tow_ogre_painc3	=[	$painc3,	tow_ogre_painc4	] {};
void()	tow_ogre_painc4	=[	$painc4,	tow_ogre_painc5	] {};
void()	tow_ogre_painc5	=[	$painc5,	tow_ogre_painc6	] {};
void()	tow_ogre_painc6	=[	$painc6,	tow_ogre_stand1	] {};


void()	tow_ogre_paind1	=[	$paind1,	tow_ogre_paind2	] {};
void()	tow_ogre_paind2	=[	$paind2,	tow_ogre_paind3	] {};
void()	tow_ogre_paind3	=[	$paind3,	tow_ogre_paind4	] {};
void()	tow_ogre_paind4	=[	$paind4,	tow_ogre_paind5	] {};
void()	tow_ogre_paind5	=[	$paind5,	tow_ogre_paind6	] {};
void()	tow_ogre_paind6	=[	$paind6,	tow_ogre_paind7	] {};
void()	tow_ogre_paind7	=[	$paind7,	tow_ogre_paind8	] {};
void()	tow_ogre_paind8	=[	$paind8,	tow_ogre_paind9	] {};
void()	tow_ogre_paind9	=[	$paind9,	tow_ogre_paind10	] {};
void()	tow_ogre_paind10=[	$paind10,	tow_ogre_paind11	] {};
void()	tow_ogre_paind11=[	$paind11,	tow_ogre_paind12	] {};
void()	tow_ogre_paind12=[	$paind12,	tow_ogre_paind13	] {};
void()	tow_ogre_paind13=[	$paind13,	tow_ogre_paind14	] {};
void()	tow_ogre_paind14=[	$paind14,	tow_ogre_paind15	] {};
void()	tow_ogre_paind15=[	$paind15,	tow_ogre_paind16	] {};
void()	tow_ogre_paind16=[	$paind16,	tow_ogre_stand1	] {};

void()	tow_ogre_paine1	=[	$paine1,	tow_ogre_paine2	] {};
void()	tow_ogre_paine2	=[	$paine2,	tow_ogre_paine3	] {};
void()	tow_ogre_paine3	=[	$paine3,	tow_ogre_paine4	] {};
void()	tow_ogre_paine4	=[	$paine4,	tow_ogre_paine5	] {};
void()	tow_ogre_paine5	=[	$paine5,	tow_ogre_paine6	] {};
void()	tow_ogre_paine6	=[	$paine6,	tow_ogre_paine7	] {};
void()	tow_ogre_paine7	=[	$paine7,	tow_ogre_paine8	] {};
void()	tow_ogre_paine8	=[	$paine8,	tow_ogre_paine9	] {};
void()	tow_ogre_paine9	=[	$paine9,	tow_ogre_paine10	] {};
void()	tow_ogre_paine10=[	$paine10,	tow_ogre_paine11	] {};
void()	tow_ogre_paine11=[	$paine11,	tow_ogre_paine12	] {};
void()	tow_ogre_paine12=[	$paine12,	tow_ogre_paine13	] {};
void()	tow_ogre_paine13=[	$paine13,	tow_ogre_paine14	] {};
void()	tow_ogre_paine14=[	$paine14,	tow_ogre_paine15	] {};
void()	tow_ogre_paine15=[	$paine15,	tow_ogre_stand1	] {};


void(entity attacker, float damage)	tow_ogre_pain =
{
	local float	r;

	// don't make multiple pain sounds right after each other
	if (self.pain_finished > time)
		return;

	sound (self, CHAN_VOICE, "ogre/ogpain1.wav", 1, ATTN_NORM);		

	r = random();
	
	if (r < 0.25)
	{
		tow_ogre_pain1 ();
		self.pain_finished = time + 1;
	}
	else if (r < 0.5)
	{
		tow_ogre_painb1 ();
		self.pain_finished = time + 1;
	}
	else if (r < 0.75)
	{
		tow_ogre_painc1 ();
		self.pain_finished = time + 1;
	}
	else if (r < 0.88)
	{
		tow_ogre_paind1 ();
		self.pain_finished = time + 2;
	}
	else
	{
		tow_ogre_paine1 ();
		self.pain_finished = time + 2;
	}
};

void()	tow_ogre_die1	=[	$death1,	tow_ogre_die2	] {};
void()	tow_ogre_die2	=[	$death2,	tow_ogre_die3	] {};
void()	tow_ogre_die3	=[	$death3,	tow_ogre_die4	] {
	self.solid = SOLID_NOT;
	self.ammo_rockets = 2;DropBackpack();
};

void()	tow_ogre_die4	=[	$death4,	tow_ogre_die5	] {};
void()	tow_ogre_die5	=[	$death5,	tow_ogre_die6	] {};
void()	tow_ogre_die6	=[	$death6,	tow_ogre_die7	] {};
void()	tow_ogre_die7	=[	$death7,	tow_ogre_die8	] {};
void()	tow_ogre_die8	=[	$death8,	tow_ogre_die9	] {};
void()	tow_ogre_die9	=[	$death9,	tow_ogre_die10	] {};
void()	tow_ogre_die10	=[	$death10,	tow_ogre_die11	] {};
void()	tow_ogre_die11	=[	$death11,	tow_ogre_die12	] {};
void()	tow_ogre_die12	=[	$death12,	tow_ogre_die13	] {};
void()	tow_ogre_die13	=[	$death13,	tow_ogre_die14	] {};
void()	tow_ogre_die14	=[	$death14,	deathRemove	] {};

void()	tow_ogre_bdie1	=[	$bdeath1,	tow_ogre_bdie2	] {};
void()	tow_ogre_bdie2	=[	$bdeath2,	tow_ogre_bdie3	] {};
void()	tow_ogre_bdie3	=[	$bdeath3,	tow_ogre_bdie4	] {
	self.solid = SOLID_NOT;
	self.ammo_rockets = 2;
	DropBackpack();
};

void()	tow_ogre_bdie4	=[	$bdeath4,	tow_ogre_bdie5	] {};
void()	tow_ogre_bdie5	=[	$bdeath5,	tow_ogre_bdie6	] {};
void()	tow_ogre_bdie6	=[	$bdeath6,	tow_ogre_bdie7	] {};
void()	tow_ogre_bdie7	=[	$bdeath7,	tow_ogre_bdie8	] {};
void()	tow_ogre_bdie8	=[	$bdeath8,	tow_ogre_bdie9	] {};
void()	tow_ogre_bdie9	=[	$bdeath9,	tow_ogre_bdie10	] {};
void()	tow_ogre_bdie10	=[	$bdeath10,	deathRemove	] {};

void() tow_ogre_die =
{
	// check for gib
	if (self.health < -80)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_ogre.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	sound (self, CHAN_VOICE, "ogre/ogdth.wav", 1, ATTN_NORM);
	
	if (random() < 0.5)
		tow_ogre_die1 ();
	else
		tow_ogre_bdie1 ();
};

void() tow_ogre_melee =
{
	if (random() > 0.5)
		tow_ogre_smash1 ();
	else
		tow_ogre_swing1 ();
};


/*QUAKED monster_enforcer (1 0 0) (-16 -16 -24) (16 16 40) Ambush*/
void(vector org, entity tow_owner) monster_tow_ogre =
{	
	
	local entity tower = spawn();
	
	tower.angles = vectoangles(aim(self, 1000));
	tower.angles_x =0;
	tower.angles_y =0;

	tower.allowPathFind = TRUE;
	
	tower.tower_owner = tow_owner;
	
	tower.tower_upgrade_points = 0;
	tower.tower_upgrade_level = 2;
	tower.solid = SOLID_SLIDEBOX;
	tower.movetype = MOVETYPE_STEP;

	setmodel (tower, "progs/ogre.mdl");

	tower.noise = "ogre/ogwake.wav";
	tower.netname = "$qc_ogre";
	tower.killstring = "$qc_ks_ogre";

	setsize (tower, '-16 -16 -24', '16 16 40');


	setorigin (tower, org + '0 0 50');

	tower.health = 200;
	tower.max_health = 200;
	
	tower.th_stand = tow_ogre_stand1;
	tower.th_walk = tow_ogre_walk1;
	tower.th_run = tow_ogre_run1;
	tower.th_die = tow_ogre_die;
	tower.th_melee = tow_ogre_melee;
	tower.th_missile = tow_ogre_nail1;
	tower.th_pain = tow_ogre_pain;
	tower.allowPathFind = TRUE;
	tower.combat_style = CS_MIXED;
	
	
	sound (tower, CHAN_VOICE, tower.noise, 1, ATTN_NORM);
	turret_monster_init (tower);
};

