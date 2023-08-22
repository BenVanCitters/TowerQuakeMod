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

SHAMBLER

==============================================================================
*/

$cd id1/models/shams
$origin 0 0 24
$base base		
$skin base

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9
$frame stand10 stand11 stand12 stand13 stand14 stand15 stand16 stand17

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 
$frame walk8 walk9 walk10 walk11 walk12

$frame	run1 run2 run3 run4 run5 run6

$frame smash1 smash2 smash3 smash4 smash5 smash6 smash7 
$frame smash8 smash9 smash10 smash11 smash12

$frame swingr1 swingr2 swingr3 swingr4 swingr5 
$frame swingr6 swingr7 swingr8 swingr9

$frame swingl1 swingl2 swingl3 swingl4 swingl5 
$frame swingl6 swingl7 swingl8 swingl9

$frame magic1 magic2 magic3 magic4 magic5 
$frame magic6 magic7 magic8 magic9 magic10 magic11 magic12

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame death1 death2 death3 death4 death5 death6 
$frame death7 death8 death9 death10 death11

void() tow_sham_stand1	=[	$stand1,	tow_sham_stand2	] {FindTowerTarget();};
void() tow_sham_stand2	=[	$stand2,	tow_sham_stand3	] {FindTowerTarget();};
void() tow_sham_stand3	=[	$stand3,	tow_sham_stand4	] {FindTowerTarget();};
void() tow_sham_stand4	=[	$stand4,	tow_sham_stand5	] {FindTowerTarget();};
void() tow_sham_stand5	=[	$stand5,	tow_sham_stand6	] {FindTowerTarget();};
void() tow_sham_stand6	=[	$stand6,	tow_sham_stand7	] {FindTowerTarget();};
void() tow_sham_stand7	=[	$stand7,	tow_sham_stand8	] {FindTowerTarget();};
void() tow_sham_stand8	=[	$stand8,	tow_sham_stand9	] {FindTowerTarget();};
void() tow_sham_stand9	=[	$stand9,	tow_sham_stand10] {FindTowerTarget();};
void() tow_sham_stand10	=[	$stand10,	tow_sham_stand11] {FindTowerTarget();};
void() tow_sham_stand11	=[	$stand11,	tow_sham_stand12] {FindTowerTarget();};
void() tow_sham_stand12	=[	$stand12,	tow_sham_stand13] {FindTowerTarget();};
void() tow_sham_stand13	=[	$stand13,	tow_sham_stand14] {FindTowerTarget();};
void() tow_sham_stand14	=[	$stand14,	tow_sham_stand15] {FindTowerTarget();};
void() tow_sham_stand15	=[	$stand15,	tow_sham_stand16] {FindTowerTarget();};
void() tow_sham_stand16	=[	$stand16,	tow_sham_stand17] {FindTowerTarget();};
void() tow_sham_stand17	=[	$stand17,	tow_sham_stand1	] {FindTowerTarget();};

void() tow_sham_walk1		=[      $walk1,        tow_sham_walk2 ] {};
void() tow_sham_walk2       =[      $walk2,        tow_sham_walk3 ] {};
void() tow_sham_walk3       =[      $walk3,        tow_sham_walk4 ] {};
void() tow_sham_walk4       =[      $walk4,        tow_sham_walk5 ] {};
void() tow_sham_walk5       =[      $walk5,        tow_sham_walk6 ] {};
void() tow_sham_walk6       =[      $walk6,        tow_sham_walk7 ] {};
void() tow_sham_walk7       =[      $walk7,        tow_sham_walk8 ] {};
void() tow_sham_walk8       =[      $walk8,        tow_sham_walk9 ] {};
void() tow_sham_walk9       =[      $walk9,        tow_sham_walk10] {};
void() tow_sham_walk10      =[      $walk10,       tow_sham_walk11] {};
void() tow_sham_walk11      =[      $walk11,       tow_sham_walk12] {};
void() tow_sham_walk12      =[      $walk12,       tow_sham_walk1 ] {
	

	if (random() > 0.8)
		sound (self, CHAN_VOICE, "shambler/sidle.wav", 1, ATTN_IDLE);
};

void() tow_sham_run1       =[      $run1,        tow_sham_run2      ] {};
void() tow_sham_run2       =[      $run2,        tow_sham_run3      ] {};
void() tow_sham_run3       =[      $run3,        tow_sham_run4      ] {};
void() tow_sham_run4       =[      $run4,        tow_sham_run5      ] {};
void() tow_sham_run5       =[      $run5,        tow_sham_run6      ] {};
void() tow_sham_run6       =[      $run6,        tow_sham_stand1      ] {
	

	if (random() > 0.8)
		sound (self, CHAN_VOICE, "shambler/sidle.wav", 1, ATTN_IDLE);
};

void() tow_sham_smash1     =[      $smash1,       tow_sham_smash2    ] {
	sound (self, CHAN_VOICE, "shambler/melee1.wav", 1, ATTN_NORM);
	
};

void() tow_sham_smash2     =[      $smash2,       tow_sham_smash3    ] {};
void() tow_sham_smash3     =[      $smash3,       tow_sham_smash4    ] {};
void() tow_sham_smash4     =[      $smash4,       tow_sham_smash5    ] {};
void() tow_sham_smash5     =[      $smash5,       tow_sham_smash6    ] {};
void() tow_sham_smash6     =[      $smash6,       tow_sham_smash7    ] {};
void() tow_sham_smash7     =[      $smash7,       tow_sham_smash8    ] {};
void() tow_sham_smash8     =[      $smash8,       tow_sham_smash9    ] {};
void() tow_sham_smash9     =[      $smash9,       tow_sham_smash10   ] {};
void() tow_sham_smash10    =[      $smash10,      tow_sham_smash11   ] {
	local vector	delta;
	local float 	ldmg;

	if (!self.enemy)
		return;

	

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 100)
		return;

	if (!CanDamage (self.enemy, self))
		return;
		
	ldmg = (random() + random() + random()) * 40;
	T_Damage (self.enemy, self, self, ldmg);
	sound (self, CHAN_VOICE, "shambler/smack.wav", 1, ATTN_NORM);

	SpawnMeatSpray (self.origin + v_forward*16, crandom() * 100 * v_right);
	SpawnMeatSpray (self.origin + v_forward*16, crandom() * 100 * v_right);
};

void() tow_sham_smash11    =[      $smash11,      tow_sham_smash12   ] {};
void() tow_sham_smash12    =[      $smash12,      tow_sham_stand1	   ] {};
void() tow_sham_swingr1;

void(float side) TowShamClaw =
{
	local vector	delta;
	local float 	ldmg;

	if (!self.enemy)
		return;

	

	delta = self.enemy.origin - self.origin;

	if (vlen(delta) > 100)
		return;
		
	ldmg = (random() + random() + random()) * 20;
	T_Damage (self.enemy, self, self, ldmg);
	sound (self, CHAN_VOICE, "shambler/smack.wav", 1, ATTN_NORM);

	if (side)
	{
		makevectorsfixed(self.angles);
		SpawnMeatSpray (self.origin + v_forward*16, side * v_right);
	}
};

void() tow_sham_swingl1	=[      $swingl1,      tow_sham_swingl2   ] {
	sound(self, CHAN_VOICE, "shambler/melee2.wav", 1, ATTN_NORM);
	
};

void() tow_sham_swingl2 =[      $swingl2,      tow_sham_swingl3   ] {};
void() tow_sham_swingl3 =[      $swingl3,      tow_sham_swingl4   ] {};
void() tow_sham_swingl4 =[      $swingl4,      tow_sham_swingl5   ] {};
void() tow_sham_swingl5 =[      $swingl5,      tow_sham_swingl6   ] {};
void() tow_sham_swingl6 =[      $swingl6,      tow_sham_swingl7   ] {};
void() tow_sham_swingl7 =[      $swingl7,      tow_sham_swingl8   ] { TowShamClaw(250);};
void() tow_sham_swingl8 =[      $swingl8,      tow_sham_swingl9   ] {};
void() tow_sham_swingl9 =[      $swingl9,      tow_sham_stand1  ] {
	

	if (random()<0.5)
		self.think = tow_sham_swingr1;
};

void() tow_sham_swingr1	=[      $swingr1,      tow_sham_swingr2   ] {
	sound (self, CHAN_VOICE, "shambler/melee1.wav", 1, ATTN_NORM);
	
};

void() tow_sham_swingr2	=[      $swingr2,      tow_sham_swingr3   ] {};
void() tow_sham_swingr3 =[      $swingr3,      tow_sham_swingr4   ] {};
void() tow_sham_swingr4 =[      $swingr4,      tow_sham_swingr5   ] {};
void() tow_sham_swingr5 =[      $swingr5,      tow_sham_swingr6   ] {};
void() tow_sham_swingr6 =[      $swingr6,      tow_sham_swingr7   ] {};
void() tow_sham_swingr7 =[      $swingr7,      tow_sham_swingr8   ] { TowShamClaw(-250);};
void() tow_sham_swingr8 =[      $swingr8,      tow_sham_swingr9   ] {};
void() tow_sham_swingr9 =[      $swingr9,      tow_sham_stand1  ] {
	
	

	if (random()<0.5)
		self.think = tow_sham_swingl1;
};

void() tow_sham_melee =
{
	local float chance;
	chance = random();

	if (chance > 0.6 || self.health == 600)
		tow_sham_smash1 ();
	else if (chance > 0.3)
		tow_sham_swingr1 ();
	else
		tow_sham_swingl1 ();
};


//============================================================================

void() TowCastLightning =
{
	local	vector	org, dir;
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	ai_face ();

	org = self.origin + '0 0 40';

	dir = self.enemy.origin + '0 0 16' - org;
	dir = normalize (dir);

	traceline (org, self.origin + dir*600, TRUE, self);

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
	WriteEntity (MSG_BROADCAST, self);
	WriteCoord (MSG_BROADCAST, org_x);
	WriteCoord (MSG_BROADCAST, org_y);
	WriteCoord (MSG_BROADCAST, org_z);
	WriteCoord (MSG_BROADCAST, trace_endpos_x);
	WriteCoord (MSG_BROADCAST, trace_endpos_y);
	WriteCoord (MSG_BROADCAST, trace_endpos_z);

    // overload the frags field which is unused on enemies
    self.frags += 1;

	LightningDamage (org, trace_endpos, self, 10);
};

void() tow_sham_magic1     =[      $magic1,       tow_sham_magic2    ] {
	ai_face();
	sound (self, CHAN_WEAPON, "shambler/sattck1.wav", 1, ATTN_NORM);
};

void() tow_sham_magic2     =[      $magic2,       tow_sham_magic3    ] {ai_face();};
void() tow_sham_magic3     =[      $magic3,       tow_sham_magic4    ] {
	ai_face();
	self.nextthink = self.nextthink + 0.2;
	local entity o;

	self.effects = self.effects | EF_MUZZLEFLASH;
	ai_face();
	self.owner = spawn();
	o = self.owner;
	setmodel (o, "progs/s_light.mdl");
	setorigin (o, self.origin);
	o.angles = self.angles;
	o.nextthink = time + 0.7;
	o.think = SUB_Remove;
};

void() tow_sham_magic4     =[      $magic4,       tow_sham_magic5    ] {
	self.effects = self.effects | EF_MUZZLEFLASH;
	self.owner.frame = 1;
};

void() tow_sham_magic5     =[      $magic5,       tow_sham_magic6    ] {
	self.effects = self.effects | EF_MUZZLEFLASH;
	self.owner.frame = 2;
};

void() tow_sham_magic6     =[      $magic6,       tow_sham_magic9    ] {
	remove (self.owner);
	TowCastLightning();
	sound (self, CHAN_WEAPON, "shambler/sboom.wav", 1, ATTN_NORM);
};

void() tow_sham_magic9     =[      $magic9,       tow_sham_magic10   ]{TowCastLightning();};
void() tow_sham_magic10    =[      $magic10,      tow_sham_magic11   ]{TowCastLightning();};
void() tow_sham_magic11    =[      $magic11,      tow_sham_magic12   ] {};

void() tow_sham_magic12    =[      $magic12,      tow_sham_stand1	   ] {};



void() tow_sham_pain1       =[      $pain1, tow_sham_pain2      ] {};
void() tow_sham_pain2       =[      $pain2, tow_sham_pain3      ] {};
void() tow_sham_pain3       =[      $pain3, tow_sham_pain4      ] {};
void() tow_sham_pain4       =[      $pain4, tow_sham_pain5      ] {};
void() tow_sham_pain5       =[      $pain5, tow_sham_pain6      ] {};
void() tow_sham_pain6       =[      $pain6, tow_sham_stand1       ] {};

void(entity attacker, float damage)	tow_sham_pain =
{
	sound (self, CHAN_VOICE, "shambler/shurt2.wav", 1, ATTN_NORM);

	if (damage >= self.health && attacker.classname == "player" && attacker.weapon == IT_AXE)
	{
		msg_entity = attacker;
		WriteByte (MSG_ONE, SVC_ACHIEVEMENT);
		WriteString(MSG_ONE, "ACH_CLOSE_SHAVE");
	}

    // overload frags field for shambler dance achievement
    if (damage >= self.health && attacker.classname == "player" && self.frags == 0)
    {
    	msg_entity = attacker;
        WriteByte (MSG_ONE, SVC_ACHIEVEMENT);
        WriteString(MSG_ONE, "ACH_SHAMBLER_DANCE");
    }

	if (self.health <= 0)
	{
		return;		// already dying, don't go into pain frame
	}

	if (random()*400 > damage)
		return;		// didn't flinch

	if (self.pain_finished > time)
		return;

	self.pain_finished = time + 2;		
	tow_sham_pain1 ();
};


//============================================================================

void() tow_sham_death1      =[      $death1,       tow_sham_death2     ] {};
void() tow_sham_death2      =[      $death2,       tow_sham_death3     ] {};
void() tow_sham_death3      =[      $death3,       tow_sham_death4     ] {self.solid = SOLID_NOT;};
void() tow_sham_death4      =[      $death4,       tow_sham_death5     ] {};
void() tow_sham_death5      =[      $death5,       tow_sham_death6     ] {};
void() tow_sham_death6      =[      $death6,       tow_sham_death7     ] {};
void() tow_sham_death7      =[      $death7,       tow_sham_death8     ] {};
void() tow_sham_death8      =[      $death8,       tow_sham_death9     ] {};
void() tow_sham_death9      =[      $death9,       tow_sham_death10    ] {};
void() tow_sham_death10     =[      $death10,      tow_sham_death11    ] {};
void() tow_sham_death11     =[      $death11,      tow_sham_death11    ] {};

void() tow_sham_die =
{
	// check for gib
	if (self.health < -60)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_shams.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	// regular death
	sound (self, CHAN_VOICE, "shambler/sdeath.wav", 1, ATTN_NORM);
	tow_sham_death1 ();
};

//============================================================================


/*QUAKED monster_shambler (1 0 0) (-32 -32 -24) (32 32 64) Ambush
*/
void(vector org, entity tow_owner) monster_tow_shambler =
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
	setmodel (tower, "progs/shambler.mdl");
	
	tower.noise = "shambler/ssight.wav";
	tower.netname = "$qc_shambler";
	tower.killstring = "$qc_ks_shambler";


	setsize (tower, VEC_HULL2_MIN, VEC_HULL2_MAX);
	tower.health = 600;
	tower.max_health = 600;

	tower.th_stand = tow_sham_stand1;
	tower.th_walk = tow_sham_walk1;
	tower.th_run = tow_sham_run1;
	tower.th_die = tow_sham_die;
	tower.th_melee = tow_sham_melee;
	tower.th_missile = tow_sham_magic1;
	tower.th_pain = tow_sham_pain;
	tower.allowPathFind = TRUE;
	tower.combat_style = CS_MIXED;

	// overload frags for lightning attack counts
	tower.frags = 0;
	
	
	turret_monster_init (tower);
};
