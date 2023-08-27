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

SOLDIER / PLAYER

==============================================================================
*/

$cd id1/models/soldier3
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11

$frame load1 load2 load3 load4 load5 load6 load7 load8 load9 load10 load11

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9 painb10
$frame painb11 painb12 painb13 painb14

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8 painc9 painc10
$frame painc11 painc12 painc13

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6 shoot7 shoot8 shoot9

$frame prowl_1 prowl_2 prowl_3 prowl_4 prowl_5 prowl_6 prowl_7 prowl_8
$frame prowl_9 prowl_10 prowl_11 prowl_12 prowl_13 prowl_14 prowl_15 prowl_16
$frame prowl_17 prowl_18 prowl_19 prowl_20 prowl_21 prowl_22 prowl_23 prowl_24


/*
==============================================================================
SOLDIER CODE
==============================================================================
*/


void() tow_army_fire;

void()	tow_army_stand1	=[	$stand1,	tow_army_stand2	] {FindTowerTarget();};
void()	tow_army_stand2	=[	$stand2,	tow_army_stand3	] {FindTowerTarget();};
void()	tow_army_stand3	=[	$stand3,	tow_army_stand4	] {FindTowerTarget();};
void()	tow_army_stand4	=[	$stand4,	tow_army_stand5	] {FindTowerTarget();};
void()	tow_army_stand5	=[	$stand5,	tow_army_stand6	] {FindTowerTarget();};
void()	tow_army_stand6	=[	$stand6,	tow_army_stand7	] {FindTowerTarget();};
void()	tow_army_stand7	=[	$stand7,	tow_army_stand8	] {FindTowerTarget();};
void()	tow_army_stand8	=[	$stand8,	tow_army_stand1	] {FindTowerTarget();};




void()	tow_army_atk1	=[	$shoot1,	tow_army_atk2	] {ai_face();};
void()	tow_army_atk2	=[	$shoot2,	tow_army_atk3	] {ai_face();};
void()	tow_army_atk3	=[	$shoot3,	tow_army_atk4	] {ai_face();};
void()	tow_army_atk4	=[	$shoot4,	tow_army_atk5	] {ai_face();};
void()	tow_army_atk5	=[	$shoot5,	tow_army_atk6	] {
	ai_face();
	tow_army_fire();
	self.effects = self.effects | EF_MUZZLEFLASH;
};
void()	tow_army_atk6	=[	$shoot6,	tow_army_atk7	] {ai_face();};
void()	tow_army_atk7	=[	$shoot7,	tow_army_atk8	] {
	ai_face();
	SUB_CheckRefire
	(tow_army_atk1);
};
void()	tow_army_atk8	=[	$shoot8,	tow_army_atk9	] {ai_face();};
void()	tow_army_atk9	=[	$shoot9,	tow_army_stand1	] {ai_face();};


void()	tow_army_pain1	=[	$pain1,		tow_army_pain2	] {};
void()	tow_army_pain2	=[	$pain2,		tow_army_pain3	] {};
void()	tow_army_pain3	=[	$pain3,		tow_army_pain4	] {};
void()	tow_army_pain4	=[	$pain4,		tow_army_pain5	] {};
void()	tow_army_pain5	=[	$pain5,		tow_army_pain6	] {};
void()	tow_army_pain6	=[	$pain6,		tow_army_stand1	] {};

void()	tow_army_painb1	=[	$painb1,	tow_army_painb2	] {};
void()	tow_army_painb2	=[	$painb2,	tow_army_painb3	] {};
void()	tow_army_painb3	=[	$painb3,	tow_army_painb4	] {};
void()	tow_army_painb4	=[	$painb4,	tow_army_painb5	] {};
void()	tow_army_painb5	=[	$painb5,	tow_army_painb6	] {};
void()	tow_army_painb6	=[	$painb6,	tow_army_painb7	] {};
void()	tow_army_painb7	=[	$painb7,	tow_army_painb8	] {};
void()	tow_army_painb8	=[	$painb8,	tow_army_painb9	] {};
void()	tow_army_painb9	=[	$painb9,	tow_army_painb10] {};
void()	tow_army_painb10	=[	$painb10,	tow_army_painb11] {};
void()	tow_army_painb11	=[	$painb11,	tow_army_painb12] {};
void()	tow_army_painb12	=[	$painb12,	tow_army_painb13] {};
void()	tow_army_painb13	=[	$painb13,	tow_army_painb14] {};
void()	tow_army_painb14	=[	$painb14,	tow_army_stand1	] {};

void()	tow_army_painc1	=[	$painc1,	tow_army_painc2	] {};
void()	tow_army_painc2	=[	$painc2,	tow_army_painc3	] {};
void()	tow_army_painc3	=[	$painc3,	tow_army_painc4	] {};
void()	tow_army_painc4	=[	$painc4,	tow_army_painc5	] {};
void()	tow_army_painc5	=[	$painc5,	tow_army_painc6	] {};
void()	tow_army_painc6	=[	$painc6,	tow_army_painc7	] {};
void()	tow_army_painc7	=[	$painc7,	tow_army_painc8	] {};
void()	tow_army_painc8	=[	$painc8,	tow_army_painc9	] {};
void()	tow_army_painc9	=[	$painc9,	tow_army_painc10] {};
void()	tow_army_painc10=[	$painc10,	tow_army_painc11] {};
void()	tow_army_painc11=[	$painc11,	tow_army_painc12] {};
void()	tow_army_painc12=[	$painc12,	tow_army_painc13] {};
void()	tow_army_painc13=[	$painc13,	tow_army_stand1] {};

void(entity attacker, float damage)	tow_army_pain =
{
	local float r;
	
	if (self.pain_finished > time)
		return;

	r = random();

	if (r < 0.2)
	{
		self.pain_finished = time + 0.6;
		tow_army_pain1 ();
		sound (self, CHAN_VOICE, "soldier/pain1.wav", 1, ATTN_NORM);
	}
	else if (r < 0.6)
	{
		self.pain_finished = time + 1.1;
		tow_army_painb1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
	else
	{
		self.pain_finished = time + 1.1;
		tow_army_painc1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
};


void() tow_army_fire =
{
	local	vector	dir;
	local	entity	en;
	
	ai_face();
	
	sound (self, CHAN_WEAPON, "soldier/sattck1.wav", 1, ATTN_NORM);	

	// fire somewhat behind the player, so a dodging player is harder to hit
	en = self.enemy;
	
	dir = en.origin - en.velocity*0.2;
	dir = normalize (dir - self.origin);
	
	FireBullets (4, dir, '0.1 0.1 0');
};



void()	tow_army_die1	=[	$death1,	tow_army_die2	] {};
void()	tow_army_die2	=[	$death2,	tow_army_die3	] {};
void()	tow_army_die3	=[	$death3,	tow_army_die4	] {
	self.solid = SOLID_NOT;
	self.ammo_shells = 5;
	DropBackpack();
};

void()	tow_army_die4	=[	$death4,	tow_army_die5	] {};
void()	tow_army_die5	=[	$death5,	tow_army_die6	] {};
void()	tow_army_die6	=[	$death6,	tow_army_die7	] {};
void()	tow_army_die7	=[	$death7,	tow_army_die8	] {};
void()	tow_army_die8	=[	$death8,	tow_army_die9	] {};
void()	tow_army_die9	=[	$death9,	tow_army_die10	] {};
void()	tow_army_die10	=[	$death10,	deathRemove	] {};

void()	tow_army_cdie1	=[	$deathc1,	tow_army_cdie2	] {};
void()	tow_army_cdie2	=[	$deathc2,	tow_army_cdie3	] {};
void()	tow_army_cdie3	=[	$deathc3,	tow_army_cdie4	] {
	self.solid = SOLID_NOT;
	self.ammo_shells = 5;
	DropBackpack();
};

void()	tow_army_cdie4	=[	$deathc4,	tow_army_cdie5	] {};
void()	tow_army_cdie5	=[	$deathc5,	tow_army_cdie6	] {};
void()	tow_army_cdie6	=[	$deathc6,	tow_army_cdie7	] {};
void()	tow_army_cdie7	=[	$deathc7,	tow_army_cdie8	] {};
void()	tow_army_cdie8	=[	$deathc8,	tow_army_cdie9	] {};
void()	tow_army_cdie9	=[	$deathc9,	tow_army_cdie10	] {};
void()	tow_army_cdie10	=[	$deathc10,	tow_army_cdie11	] {};
void()	tow_army_cdie11	=[	$deathc11,	deathRemove	] {};


void() tow_army_die =
{
	// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_guard.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	// regular death
	sound (self, CHAN_VOICE, "soldier/death1.wav", 1, ATTN_NORM);
	if (random() < 0.5)
		tow_army_die1 ();
	else
		tow_army_cdie1 ();
};

void()	tow_run_tmp = {
	bprint("agh!\n");
	self.ammo_shells = 5;
	DropBackpack();
	army_run1();
};
/*QUAKED monster_army (1 0 0) (-16 -16 -24) (16 16 40) Ambush*/
void(vector org, entity tow_owner) monster_tow_army =
{	

	bprint("spawning tower army for ");
	bprint(tow_owner.netname );
	bprint("\n");
	
	local entity tower = spawn();

	local vector myAngle = tow_owner.v_angle;
	myAngle_x = myAngle_z = 0; // zero out the x and z rotations		
	tower.angles = myAngle;
	
	
	tower.tower_upgrade_points = 0;
	tower.tower_upgrade_level = 0;
	
	tower.solid = SOLID_SLIDEBOX ;
	tower.movetype = MOVETYPE_STEP;
	tower.classname = "monster_army";
	setmodel (tower, "progs/soldier.mdl");
	tower.tower_owner = tow_owner;
	tower.noise = "soldier/sight1.wav";
	tower.netname = "$qc_grunt";
	tower.killstring = "$qc_ks_grunt";

	setsize (tower, '-16 -16 -24', '16 16 40');
	setorigin (tower, org + '0 0 50');
	tower.health = 30;
	tower.max_health = 30;

	tower.th_stand = tow_army_stand1;
	tower.th_walk = army_walk1;
	tower.th_run = tow_run_tmp;
	tower.th_missile = tow_army_atk1;
	tower.th_pain = tow_army_pain;
	tower.th_die = tow_army_die;
	tower.allowPathFind = TRUE;
	tower.combat_style = CS_RANGED;
	
	sound (tower, CHAN_VOICE, "soldier/sight1.wav", 1, ATTN_NORM);
	turret_monster_init (tower);
};
