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

SHAL-RATH

==============================================================================
*/
$cd id1/models/shalrath
$origin 0 0 24
$base base
$skin skin
$scale 0.7

$frame attack1 attack2 attack3 attack4 attack5 attack6 attack7 attack8
$frame attack9 attack10 attack11

$frame pain1 pain2 pain3 pain4 pain5 

$frame death1 death2 death3 death4 death5 death6 death7

$frame	walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame	walk11 walk12

void(entity attacker, float damage) tow_shalrath_pain;
void() TowShalMissile;
void() tow_shal_stand     =[      $walk1,       tow_shal_stand    ] {FindTowerTarget();};

void() tow_shal_walk1     =[      $walk2,       tow_shal_walk2    ] {
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);

};

void() tow_shal_walk2     =[      $walk3,       tow_shal_walk3    ] {};
void() tow_shal_walk3     =[      $walk4,       tow_shal_walk4    ] {};
void() tow_shal_walk4     =[      $walk5,       tow_shal_walk5    ] {};
void() tow_shal_walk5     =[      $walk6,       tow_shal_walk6    ] {};
void() tow_shal_walk6     =[      $walk7,       tow_shal_walk7    ] {};
void() tow_shal_walk7     =[      $walk8,       tow_shal_walk8    ] {};
void() tow_shal_walk8     =[      $walk9,       tow_shal_walk9    ] {};
void() tow_shal_walk9     =[      $walk10,       tow_shal_walk10    ] {};
void() tow_shal_walk10    =[      $walk11,       tow_shal_walk11    ] {};
void() tow_shal_walk11    =[      $walk12,       tow_shal_walk12    ] {};
void() tow_shal_walk12    =[      $walk1,       tow_shal_walk1    ] {};

void() tow_shal_run1     =[      $walk2,       tow_shal_run2    ] {
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);

	
};

void() tow_shal_run2     =[      $walk3,       tow_shal_run3    ] {};
void() tow_shal_run3     =[      $walk4,       tow_shal_run4    ] {};
void() tow_shal_run4     =[      $walk5,       tow_shal_run5    ] {};
void() tow_shal_run5     =[      $walk6,       tow_shal_run6    ] {};
void() tow_shal_run6     =[      $walk7,       tow_shal_run7    ] {};
void() tow_shal_run7     =[      $walk8,       tow_shal_run8    ] {};
void() tow_shal_run8     =[      $walk9,       tow_shal_run9    ] {};
void() tow_shal_run9     =[      $walk10,       tow_shal_run10    ] {};
void() tow_shal_run10    =[      $walk11,       tow_shal_run11    ] {};
void() tow_shal_run11    =[      $walk12,       tow_shal_run12    ] {};
void() tow_shal_run12    =[      $walk1,       tow_shal_stand    ] {};

void() tow_shal_attack1     =[      $attack1,       tow_shal_attack2    ] {
	sound (self, CHAN_VOICE, "shalrath/attack.wav", 1, ATTN_NORM);
	ai_face();
};

void() tow_shal_attack2     =[      $attack2,       tow_shal_attack3    ] {ai_face();};
void() tow_shal_attack3     =[      $attack3,       tow_shal_attack4    ] {ai_face();};
void() tow_shal_attack4     =[      $attack4,       tow_shal_attack5    ] {ai_face();};
void() tow_shal_attack5     =[      $attack5,       tow_shal_attack6    ] {ai_face();};
void() tow_shal_attack6     =[      $attack6,       tow_shal_attack7    ] {ai_face();};
void() tow_shal_attack7     =[      $attack7,       tow_shal_attack8    ] {ai_face();};
void() tow_shal_attack8     =[      $attack8,       tow_shal_attack9    ] {ai_face();};
void() tow_shal_attack9     =[      $attack9,       tow_shal_attack10   ] {TowShalMissile();};
void() tow_shal_attack10    =[      $attack10,      tow_shal_attack11   ] {ai_face();};
void() tow_shal_attack11    =[      $attack11,      tow_shal_stand   ] {};

void() tow_shal_pain1       =[      $pain1, tow_shal_pain2      ] {};
void() tow_shal_pain2       =[      $pain2, tow_shal_pain3      ] {};
void() tow_shal_pain3       =[      $pain3, tow_shal_pain4      ] {};
void() tow_shal_pain4       =[      $pain4, tow_shal_pain5      ] {};
void() tow_shal_pain5       =[      $pain5, tow_shal_stand      ] {};

void() tow_shal_death1      =[      $death1,        tow_shal_death2     ] {};
void() tow_shal_death2      =[      $death2,        tow_shal_death3     ] {};
void() tow_shal_death3      =[      $death3,        tow_shal_death4     ] {};
void() tow_shal_death4      =[      $death4,        tow_shal_death5     ] {};
void() tow_shal_death5      =[      $death5,        tow_shal_death6     ] {};
void() tow_shal_death6      =[      $death6,        tow_shal_death7     ] {};
void() tow_shal_death7      =[      $death7,        deathRemove    ] {};


void(entity attacker, float damage) tow_shalrath_pain =
{
	if (self.pain_finished > time)
		return;

	sound (self, CHAN_VOICE, "shalrath/pain.wav", 1, ATTN_NORM);
	tow_shal_pain1();
	self.pain_finished = time + 3;
};

void() tow_shalrath_die =
{
	// check for gib
	if (self.health < -90)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_shal.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	sound (self, CHAN_VOICE, "shalrath/death.wav", 1, ATTN_NORM);
	tow_shal_death1();
	self.solid = SOLID_NOT;
	// insert death sounds here
};

/*
================
TowShalMissile
================
*/
void() TowShalMissileTouch;
void() TowShalHome;
void() TowShalMissile =
{
	local	entity 	missile;
	local	vector	dir;
	local	float	dist, flytime;

	dir = normalize((self.enemy.origin + '0 0 10') - self.origin);
	dist = vlen (self.enemy.origin - self.origin);
	flytime = dist * 0.002;

	if (flytime < 0.1)
		flytime = 0.1;

	self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "shalrath/attack2.wav", 1, ATTN_NORM);

	missile = spawn ();
	missile.classname = "vore_ball";
	missile.owner = self;

	missile.solid = SOLID_BBOX;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/v_spike.mdl");

	setsize (missile, '0 0 0', '0 0 0');		

	missile.origin = self.origin + '0 0 10';
	missile.velocity = dir * 400;
	missile.avelocity = '300 300 300';
	missile.nextthink = flytime + time;
	missile.think = TowShalHome;
	missile.enemy = self.enemy;
	missile.touch = TowShalMissileTouch;
};

void() TowShalHome =
{
	local vector	dir, vtemp;
	vtemp = self.enemy.origin + '0 0 10';

	if (self.enemy.health < 1)
	{
		remove(self);
		return;
	}

	dir = normalize(vtemp - self.origin);

	self.velocity = dir * 250;

	self.nextthink = time + 0.2;
	self.think = TowShalHome;	
};

void() TowShalMissileTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner

	if (other.classname == "monster_zombie")
		T_Damage (other, self, self, 110);	

	T_RadiusDamage (self, self.owner, 40, world);
	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);

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

//=================================================================

/*QUAKED monster_shalrath (1 0 0) (-32 -32 -24) (32 32 48) Ambush
*/
void(vector org, entity tow_owner) monster_tow_shalrath =
{
	local entity tower = spawn();
	
	tower.angles = vectoangles(aim(self, 1000));
	tower.angles_x =0;
	tower.angles_y =0;
	
	
	setorigin (tower, org + '0 0 50');
	
	tower.tower_upgrade_points = 0;
	tower.tower_upgrade_level = 4;
	
	tower.tower_owner = tow_owner;

	tower.solid = SOLID_SLIDEBOX;
	tower.movetype = MOVETYPE_STEP;
	
	setmodel (tower, "progs/shalrath.mdl");

	tower.noise = "shalrath/sight.wav";
	tower.netname = "$qc_vore";
	tower.killstring = "$qc_ks_vore";

	setsize (tower, '-16 -16 -24', '16 16 40');
	tower.health = 400;
	tower.max_health = 400;

	tower.th_stand = tow_shal_stand;
	tower.th_walk = tow_shal_walk1;
	tower.th_run = tow_shal_run1;
	tower.th_die = tow_shalrath_die;
	tower.th_pain = tow_shalrath_pain;
	tower.th_missile = tow_shal_attack1;
	tower.allowPathFind = TRUE;
	tower.combat_style = CS_RANGED;


	sound (tower, CHAN_VOICE, tower.noise, 1, ATTN_NORM);
	turret_monster_init (tower);
};
