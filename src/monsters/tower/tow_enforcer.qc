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

$cd id1/models/enforcer
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame walk11 walk12 walk13 walk14 walk15 walk16

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame attack1 attack2 attack3 attack4 attack5 attack6
$frame attack7 attack8 attack9 attack10

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10 death11 death12 death13 death14

$frame fdeath1 fdeath2 fdeath3 fdeath4 fdeath5 fdeath6 fdeath7 fdeath8
$frame fdeath9 fdeath10 fdeath11

$frame paina1 paina2 paina3 paina4

$frame painb1 painb2 painb3 painb4 painb5

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8

$frame paind1 paind2 paind3 paind4 paind5 paind6 paind7 paind8
$frame paind9 paind10 paind11 paind12 paind13 paind14 paind15 paind16
$frame paind17 paind18 paind19


void() tow_Laser_Touch =
{
	local vector org;
	
	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}
	
	sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_STATIC);
	org = self.origin - 8*normalize(self.velocity);

	if (other.health)
	{
		SpawnBlood (org, self.velocity*0.2, 15);
		T_Damage (other, self, self.owner, 15);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}
	
	remove(self);	
};

void(vector org, vector vec) tow_LaunchLaser =
{		
	if (self.classname == "monster_enforcer")
		sound (self, CHAN_WEAPON, "enforcer/enfire.wav", 1, ATTN_NORM);

	vec = normalize(vec);
	
	newmis = spawn();
	newmis.classname = "enforcer_laser";
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;

	setmodel (newmis, "progs/laser.mdl");
	setsize (newmis, '0 0 0', '0 0 0');		

	setorigin (newmis, org);

	newmis.velocity = vec * 600;
	newmis.angles = vectoangles(newmis.velocity);

	newmis.nextthink = time + 5;
	newmis.think = SUB_Remove;
	newmis.touch = Laser_Touch;
};



void() tow_enforcer_fire =
{
	local vector org;

	self.effects = self.effects | EF_MUZZLEFLASH;
	makevectorsfixed(self.angles);
	
	org = self.origin + v_forward * 30 + v_right * 8.5 + '0 0 16';

	LaunchLaser(org, self.enemy.origin - self.origin);
};

//============================================================================

void()	tow_enf_stand1	=[	$stand1,	tow_enf_stand2	] {FindTowerTarget();};
void()	tow_enf_stand2	=[	$stand2,	tow_enf_stand3	] {FindTowerTarget();};
void()	tow_enf_stand3	=[	$stand3,	tow_enf_stand4	] {FindTowerTarget();};
void()	tow_enf_stand4	=[	$stand4,	tow_enf_stand5	] {FindTowerTarget();};
void()	tow_enf_stand5	=[	$stand5,	tow_enf_stand6	] {FindTowerTarget();};
void()	tow_enf_stand6	=[	$stand6,	tow_enf_stand7	] {FindTowerTarget();};
void()	tow_enf_stand7	=[	$stand7,	tow_enf_stand1	] {FindTowerTarget();};

void()	tow_enf_walk1	=[	$walk1 ,	tow_enf_walk2	] {
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "enforcer/idle1.wav", 1, ATTN_IDLE);

	ai_walk(2);
};

void()	tow_enf_walk2	=[	$walk2 ,	tow_enf_walk3	] {ai_walk(4);};
void()	tow_enf_walk3	=[	$walk3 ,	tow_enf_walk4	] {ai_walk(4);};
void()	tow_enf_walk4	=[	$walk4 ,	tow_enf_walk5	] {ai_walk(3);};
void()	tow_enf_walk5	=[	$walk5 ,	tow_enf_walk6	] {ai_walk(1);};
void()	tow_enf_walk6	=[	$walk6 ,	tow_enf_walk7	] {ai_walk(2);};
void()	tow_enf_walk7	=[	$walk7 ,	tow_enf_walk8	] {ai_walk(2);};
void()	tow_enf_walk8	=[	$walk8 ,	tow_enf_walk9	] {ai_walk(1);};
void()	tow_enf_walk9	=[	$walk9 ,	tow_enf_walk10	] {ai_walk(2);};
void()	tow_enf_walk10	=[	$walk10,	tow_enf_walk11	] {ai_walk(4);};
void()	tow_enf_walk11	=[	$walk11,	tow_enf_walk12	] {ai_walk(4);};
void()	tow_enf_walk12	=[	$walk12,	tow_enf_walk13	] {ai_walk(1);};
void()	tow_enf_walk13	=[	$walk13,	tow_enf_walk14	] {ai_walk(2);};
void()	tow_enf_walk14	=[	$walk14,	tow_enf_walk15	] {ai_walk(3);};
void()	tow_enf_walk15	=[	$walk15,	tow_enf_walk16	] {ai_walk(4);};
void()	tow_enf_walk16	=[	$walk16,	tow_enf_walk1	] {ai_walk(2);};

void()	tow_enf_run1	=[	$run1  ,	tow_enf_run2	] {
	if (random() < 0.2)
		sound (self, CHAN_VOICE, "enforcer/idle1.wav", 1, ATTN_IDLE);

	ai_run(18);
};

void()	tow_enf_run2	=[	$run2  ,	tow_enf_run3	] {bprint("somehow enf run was started?\n"); };
void()	tow_enf_run3	=[	$run3  ,	tow_enf_run4	] {};
void()	tow_enf_run4	=[	$run4  ,	tow_enf_run5	] {};
void()	tow_enf_run5	=[	$run5  ,	tow_enf_run6	] {};
void()	tow_enf_run6	=[	$run6  ,	tow_enf_run7	] {};
void()	tow_enf_run7	=[	$run7  ,	tow_enf_run8	] {};
void()	tow_enf_run8	=[	$run8  ,	tow_enf_stand1	] {};

void()	tow_enf_atk1	=[	$attack1,	tow_enf_atk2	] {ai_face();};
void()	tow_enf_atk2	=[	$attack2,	tow_enf_atk3	] {ai_face();};
void()	tow_enf_atk3	=[	$attack3,	tow_enf_atk4	] {ai_face();};
void()	tow_enf_atk4	=[	$attack4,	tow_enf_atk5	] {ai_face();};
void()	tow_enf_atk5	=[	$attack5,	tow_enf_atk6	] {ai_face();};
void()	tow_enf_atk6	=[	$attack6,	tow_enf_atk7	] {enforcer_fire();};
void()	tow_enf_atk7	=[	$attack7,	tow_enf_atk8	] {ai_face();};
void()	tow_enf_atk8	=[	$attack8,	tow_enf_atk9	] {ai_face();};
void()	tow_enf_atk9	=[	$attack5,	tow_enf_atk10	] {ai_face();};
void()	tow_enf_atk10	=[	$attack6,	tow_enf_atk11	] {enforcer_fire();};
void()	tow_enf_atk11	=[	$attack7,	tow_enf_atk12	] {ai_face();};
void()	tow_enf_atk12	=[	$attack8,	tow_enf_atk13	] {ai_face();};
void()	tow_enf_atk13	=[	$attack9,	tow_enf_atk14	] {ai_face();};
void()	tow_enf_atk14	=[	$attack10,	tow_enf_stand1	] {
	ai_face();
	SUB_CheckRefire( tow_enf_atk1 );
};

void()	tow_enf_paina1	=[	$paina1,	tow_enf_paina2	] {};
void()	tow_enf_paina2	=[	$paina2,	tow_enf_paina3	] {};
void()	tow_enf_paina3	=[	$paina3,	tow_enf_paina4	] {};
void()	tow_enf_paina4	=[	$paina4,	tow_enf_stand1	] {};

void()	tow_enf_painb1	=[	$painb1,	tow_enf_painb2	] {};
void()	tow_enf_painb2	=[	$painb2,	tow_enf_painb3	] {};
void()	tow_enf_painb3	=[	$painb3,	tow_enf_painb4	] {};
void()	tow_enf_painb4	=[	$painb4,	tow_enf_painb5	] {};
void()	tow_enf_painb5	=[	$painb5,	tow_enf_stand1	] {};

void()	tow_enf_painc1	=[	$painc1,	tow_enf_painc2	] {};
void()	tow_enf_painc2	=[	$painc2,	tow_enf_painc3	] {};
void()	tow_enf_painc3	=[	$painc3,	tow_enf_painc4	] {};
void()	tow_enf_painc4	=[	$painc4,	tow_enf_painc5	] {};
void()	tow_enf_painc5	=[	$painc5,	tow_enf_painc6	] {};
void()	tow_enf_painc6	=[	$painc6,	tow_enf_painc7	] {};
void()	tow_enf_painc7	=[	$painc7,	tow_enf_painc8	] {};
void()	tow_enf_painc8	=[	$painc8,	tow_enf_stand1	] {};

void()	tow_enf_paind1	=[	$paind1,	tow_enf_paind2	] {};
void()	tow_enf_paind2	=[	$paind2,	tow_enf_paind3	] {};
void()	tow_enf_paind3	=[	$paind3,	tow_enf_paind4	] {};
void()	tow_enf_paind4	=[	$paind4,	tow_enf_paind5	] {};
void()	tow_enf_paind5	=[	$paind5,	tow_enf_paind6	] {};
void()	tow_enf_paind6	=[	$paind6,	tow_enf_paind7	] {};
void()	tow_enf_paind7	=[	$paind7,	tow_enf_paind8	] {};
void()	tow_enf_paind8	=[	$paind8,	tow_enf_paind9	] {};
void()	tow_enf_paind9	=[	$paind9,	tow_enf_paind10	] {};
void()	tow_enf_paind10	=[	$paind10,	tow_enf_paind11	] {};
void()	tow_enf_paind11	=[	$paind11,	tow_enf_paind12	] {};
void()	tow_enf_paind12	=[	$paind12,	tow_enf_paind13	] {};
void()	tow_enf_paind13	=[	$paind13,	tow_enf_paind14	] {};
void()	tow_enf_paind14	=[	$paind14,	tow_enf_paind15	] {};
void()	tow_enf_paind15	=[	$paind15,	tow_enf_paind16	] {};
void()	tow_enf_paind16	=[	$paind16,	tow_enf_paind17	] {};
void()	tow_enf_paind17	=[	$paind17,	tow_enf_paind18	] {};
void()	tow_enf_paind18	=[	$paind18,	tow_enf_paind19	] {};
void()	tow_enf_paind19	=[	$paind19,	tow_enf_stand1	] {};

void(entity attacker, float damage)	tow_enf_pain =
{
	local float r;

	r = random ();
	if (self.pain_finished > time)
		return;

	
	if (r < 0.5)
		sound (self, CHAN_VOICE, "enforcer/pain1.wav", 1, ATTN_NORM);
	else
		sound (self, CHAN_VOICE, "enforcer/pain2.wav", 1, ATTN_NORM);

	if (r < 0.2)
	{
		self.pain_finished = time + 1;
		tow_enf_paina1 ();
	}
	else if (r < 0.4)
	{
		self.pain_finished = time + 1;
		tow_enf_painb1 ();
	}
	else if (r < 0.7)
	{
		self.pain_finished = time + 1;
		tow_enf_painc1 ();
	}
	else
	{
		self.pain_finished = time + 2;
		tow_enf_paind1 ();
	}
};

//============================================================================




void()	tow_enf_die1	=[	$death1,	tow_enf_die2	] {};
void()	tow_enf_die2	=[	$death2,	tow_enf_die3	] {};
void()	tow_enf_die3	=[	$death3,	tow_enf_die4	] {
	self.solid = SOLID_NOT;
	self.ammo_cells = 5;
	DropBackpack();
};

void()	tow_enf_die4	=[	$death4,	tow_enf_die5	] {ai_forward(14);};
void()	tow_enf_die5	=[	$death5,	tow_enf_die6	] {ai_forward(2);};
void()	tow_enf_die6	=[	$death6,	tow_enf_die7	] {};
void()	tow_enf_die7	=[	$death7,	tow_enf_die8	] {};
void()	tow_enf_die8	=[	$death8,	tow_enf_die9	] {};
void()	tow_enf_die9	=[	$death9,	tow_enf_die10	] {ai_forward(3);};
void()	tow_enf_die10	=[	$death10,	tow_enf_die11	] {ai_forward(5);};
void()	tow_enf_die11	=[	$death11,	tow_enf_die12	] {ai_forward(5);};
void()	tow_enf_die12	=[	$death12,	tow_enf_die13	] {ai_forward(5);};
void()	tow_enf_die13	=[	$death13,	tow_enf_die14	] {};
void()	tow_enf_die14	=[	$death14,	deathRemove	] {};

void()	tow_enf_fdie1	=[	$fdeath1,	tow_enf_fdie2	] {};
void()	tow_enf_fdie2	=[	$fdeath2,	tow_enf_fdie3	] {};
void()	tow_enf_fdie3	=[	$fdeath3,	tow_enf_fdie4	] {
	self.solid = SOLID_NOT;
	self.ammo_cells = 5;
	DropBackpack();
};

void()	tow_enf_fdie4	=[	$fdeath4,	tow_enf_fdie5	] {};
void()	tow_enf_fdie5	=[	$fdeath5,	tow_enf_fdie6	] {};
void()	tow_enf_fdie6	=[	$fdeath6,	tow_enf_fdie7	] {};
void()	tow_enf_fdie7	=[	$fdeath7,	tow_enf_fdie8	] {};
void()	tow_enf_fdie8	=[	$fdeath8,	tow_enf_fdie9	] {};
void()	tow_enf_fdie9	=[	$fdeath9,	tow_enf_fdie10	] {};
void()	tow_enf_fdie10	=[	$fdeath10,	tow_enf_fdie11	] {};
void()	tow_enf_fdie11	=[	$fdeath11,	deathRemove	] {};


void() tow_enf_die =
{
	// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_mega.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	// regular death
	sound (self, CHAN_VOICE, "enforcer/death1.wav", 1, ATTN_NORM);

	if (random() > 0.5)
		tow_enf_die1 ();
	else
		tow_enf_fdie1 ();
};


/*QUAKED monster_enforcer (1 0 0) (-16 -16 -24) (16 16 40) Ambush*/
void(vector org, entity tow_owner) monster_tow_enforcer =
{	
	bprint("spawning tower army for ");
	bprint(tow_owner.netname );
	bprint("\n");
	
	local entity tower = spawn();
	
	tower.angles = vectoangles(aim(self, 1000));
	tower.angles_x =0;
	tower.angles_y =0;

	tower.allowPathFind = TRUE;
	tower.combat_style = CS_RANGED;


	
	tower.solid = SOLID_SLIDEBOX;
	tower.movetype = MOVETYPE_STEP;
	tower.classname = "monster_army";
	setmodel (tower, "progs/enforcer.mdl");
	tower.tower_owner = tow_owner;
	tower.noise = "enforcer/sight1.wav";
	tower.noise1 = "enforcer/sight2.wav";
	tower.noise2 = "enforcer/sight3.wav";
	tower.noise3 = "enforcer/sight4.wav";
	
	tower.tower_upgrade_points = 0;
	tower.tower_upgrade_level = 1;
	tower.netname = "$qc_enforcer";

	tower.killstring = "$qc_ks_enforcer";

	setsize (tower, '-16 -16 -24', '16 16 40');
	setorigin (tower, org + '0 0 50');

	tower.health = 80;
	tower.max_health = 80;
	
	tower.th_stand = tow_enf_stand1;
	tower.th_walk = tow_enf_walk1;
	tower.th_run = tow_enf_run1;
	tower.th_pain = tow_enf_pain;
	tower.th_die = tow_enf_die;
	tower.th_missile = tow_enf_atk1;
	
	
	sound (tower, CHAN_VOICE, tower.noise, 1, ATTN_NORM);
	turret_monster_init (tower);
};