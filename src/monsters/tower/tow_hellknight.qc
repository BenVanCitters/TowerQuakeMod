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

KNIGHT

==============================================================================
*/

$cd id1/models/knight2
$origin 0 0 24
$base base
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8 stand9

$frame walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9
$frame walk10 walk11 walk12 walk13 walk14 walk15 walk16 walk17
$frame walk18 walk19 walk20

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame pain1 pain2 pain3 pain4 pain5

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10 death11 death12

$frame deathb1 deathb2 deathb3 deathb4 deathb5 deathb6 deathb7 deathb8
$frame deathb9

$frame char_a1 char_a2 char_a3 char_a4 char_a5 char_a6 char_a7 char_a8
$frame char_a9 char_a10 char_a11 char_a12 char_a13 char_a14 char_a15 char_a16

$frame magica1 magica2 magica3 magica4 magica5 magica6 magica7 magica8
$frame magica9 magica10 magica11 magica12 magica13 magica14

$frame magicb1 magicb2 magicb3 magicb4 magicb5 magicb6 magicb7 magicb8
$frame magicb9 magicb10 magicb11 magicb12 magicb13

$frame char_b1 char_b2 char_b3 char_b4 char_b5 char_b6

$frame slice1 slice2 slice3 slice4 slice5 slice6 slice7 slice8 slice9 slice10

$frame smash1 smash2 smash3 smash4 smash5 smash6 smash7 smash8 smash9 smash10
$frame smash11

$frame w_attack1 w_attack2 w_attack3 w_attack4 w_attack5 w_attack6 w_attack7 
$frame w_attack8 w_attack9 w_attack10 w_attack11 w_attack12 w_attack13 w_attack14
$frame w_attack15 w_attack16 w_attack17 w_attack18 w_attack19 w_attack20 
$frame w_attack21 w_attack22 

$frame magicc1 magicc2 magicc3 magicc4 magicc5 magicc6 magicc7 magicc8
$frame magicc9 magicc10 magicc11


void() tow_hknight_char_a1;
void() hk_idle_sound;

void(float offset) tow_hknight_shot =
{
	local	vector	offang;
	local	vector	org, vec;
	
	offang = vectoangles (self.enemy.origin - self.origin);
	offang_y = offang_y + offset * 6;
	
	makevectors (offang);

	org = self.origin + self.mins + self.size*0.5 + v_forward * 20;

	// set missile speed
	vec = normalize (v_forward);
	vec_z = 0 - vec_z + (random() - 0.5)*0.1;
	
	launch_spike (org, vec);
	newmis.classname = "knight_spike";
	setmodel (newmis, "progs/k_spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
	newmis.velocity = vec*300;
	if (cvar("pr_checkextension"))
		if (checkextension("EX_EXTENDED_EF"))
			newmis.effects = newmis.effects | EF_CANDLELIGHT; // give the projectiles a weak glow
	sound (self, CHAN_WEAPON, "hknight/attack1.wav", 1, ATTN_NORM);
};





//===========================================================================

void()	tow_hknight_stand1	=[	$stand1,	tow_hknight_stand2	] {FindTowerTarget();};
void()	tow_hknight_stand2	=[	$stand2,	tow_hknight_stand3	] {FindTowerTarget();};
void()	tow_hknight_stand3	=[	$stand3,	tow_hknight_stand4	] {FindTowerTarget();};
void()	tow_hknight_stand4	=[	$stand4,	tow_hknight_stand5	] {FindTowerTarget();};
void()	tow_hknight_stand5	=[	$stand5,	tow_hknight_stand6	] {FindTowerTarget();};
void()	tow_hknight_stand6	=[	$stand6,	tow_hknight_stand7	] {FindTowerTarget();};
void()	tow_hknight_stand7	=[	$stand7,	tow_hknight_stand8	] {FindTowerTarget();};
void()	tow_hknight_stand8	=[	$stand8,	tow_hknight_stand9	] {FindTowerTarget();};
void()	tow_hknight_stand9	=[	$stand9,	tow_hknight_stand1	] {FindTowerTarget();};

//===========================================================================

void()	tow_hknight_walk1	=[	$walk1,		tow_hknight_walk2	] {
	hk_idle_sound();
	 
};

void()	tow_hknight_walk2	=[	$walk2,		tow_hknight_walk3	] { };
void()	tow_hknight_walk3	=[	$walk3,		tow_hknight_walk4	] { };
void()	tow_hknight_walk4	=[	$walk4,		tow_hknight_walk5	] { };
void()	tow_hknight_walk5	=[	$walk5,		tow_hknight_walk6	] { };
void()	tow_hknight_walk6	=[	$walk6,		tow_hknight_walk7	] { };
void()	tow_hknight_walk7	=[	$walk7,		tow_hknight_walk8	] { };
void()	tow_hknight_walk8	=[	$walk8,		tow_hknight_walk9	] { };
void()	tow_hknight_walk9	=[	$walk9,		tow_hknight_walk10	] { };
void()	tow_hknight_walk10	=[	$walk10,	tow_hknight_walk11	] { };
void()	tow_hknight_walk11	=[	$walk11,	tow_hknight_walk12	] { };
void()	tow_hknight_walk12	=[	$walk12,	tow_hknight_walk13	] { };
void()	tow_hknight_walk13	=[	$walk13,	tow_hknight_walk14	] { };
void()	tow_hknight_walk14	=[	$walk14,	tow_hknight_walk15	] { };
void()	tow_hknight_walk15	=[	$walk15,	tow_hknight_walk16	] { };
void()	tow_hknight_walk16	=[	$walk16,	tow_hknight_walk17	] { };
void()	tow_hknight_walk17	=[	$walk17,	tow_hknight_walk18	] { };
void()	tow_hknight_walk18	=[	$walk18,	tow_hknight_walk19	] { };
void()	tow_hknight_walk19	=[	$walk19,	tow_hknight_walk20	] { };
void()	tow_hknight_walk20	=[	$walk20,	tow_hknight_walk1	] { };

//===========================================================================

void()	tow_hknight_run1	=[	$run1,		tow_hknight_run2	] {
	hk_idle_sound();
	  
	CheckForCharge (); 
};

void()	tow_hknight_run2	=[	$run2,		tow_hknight_run3	] { };
void()	tow_hknight_run3	=[	$run3,		tow_hknight_run4	] { };
void()	tow_hknight_run4	=[	$run4,		tow_hknight_run5	] { };
void()	tow_hknight_run5	=[	$run5,		tow_hknight_run6	] { };
void()	tow_hknight_run6	=[	$run6,		tow_hknight_run7	] { };
void()	tow_hknight_run7	=[	$run7,		tow_hknight_run8	] { };
void()	tow_hknight_run8	=[	$run8,		tow_hknight_stand1	] { };

//============================================================================

void()	tow_hknight_pain1	=[	$pain1,		tow_hknight_pain2	] {
	sound (self, CHAN_VOICE, "hknight/pain1.wav", 1, ATTN_NORM);
};

void()	tow_hknight_pain2	=[	$pain2,		tow_hknight_pain3	] {};
void()	tow_hknight_pain3	=[	$pain3,		tow_hknight_pain4	] {};
void()	tow_hknight_pain4	=[	$pain4,		tow_hknight_pain5	] {};
void()	tow_hknight_pain5	=[	$pain5,		tow_hknight_stand1	] {};

//============================================================================

void()	tow_hknight_die1	=[	$death1,	tow_hknight_die2	] { };
void()	tow_hknight_die2	=[	$death2,	tow_hknight_die3	] { };
void()	tow_hknight_die3	=[	$death3,	tow_hknight_die4	] {
	self.solid = SOLID_NOT;
	 
};

void()	tow_hknight_die4	=[	$death4,	tow_hknight_die5	] {};
void()	tow_hknight_die5	=[	$death5,	tow_hknight_die6	] {};
void()	tow_hknight_die6	=[	$death6,	tow_hknight_die7	] {};
void()	tow_hknight_die7	=[	$death7,	tow_hknight_die8	] {};
void()	tow_hknight_die8	=[	$death8,	tow_hknight_die9	] { };
void()	tow_hknight_die9	=[	$death9,	tow_hknight_die10	] { };
void()	tow_hknight_die10	=[	$death10,	tow_hknight_die11	] {};
void()	tow_hknight_die11	=[	$death11,	tow_hknight_die12	] {};
void()	tow_hknight_die12	=[	$death12,	tow_hknight_die12	] {};

void()	tow_hknight_dieb1	=[	$deathb1,	tow_hknight_dieb2	] {};
void()	tow_hknight_dieb2	=[	$deathb2,	tow_hknight_dieb3	] {};
void()	tow_hknight_dieb3	=[	$deathb3,	tow_hknight_dieb4	] {self.solid = SOLID_NOT;};
void()	tow_hknight_dieb4	=[	$deathb4,	tow_hknight_dieb5	] {};
void()	tow_hknight_dieb5	=[	$deathb5,	tow_hknight_dieb6	] {};
void()	tow_hknight_dieb6	=[	$deathb6,	tow_hknight_dieb7	] {};
void()	tow_hknight_dieb7	=[	$deathb7,	tow_hknight_dieb8	] {};
void()	tow_hknight_dieb8	=[	$deathb8,	tow_hknight_dieb9	] {};
void()	tow_hknight_dieb9	=[	$deathb9,	tow_hknight_dieb9	] {};

void() tow_hknight_die =
{
	// check for gib
	if (self.health < -40)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_hellkn.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	// regular death
	sound (self, CHAN_VOICE, "hknight/death1.wav", 1, ATTN_NORM);

	if (random() > 0.5)
		tow_hknight_die1 ();
	else
		tow_hknight_dieb1 ();
};


//============================================================================

void()	tow_hknight_magica1 =[	$magica1,	tow_hknight_magica2	] {ai_face();};
void()	tow_hknight_magica2 =[	$magica2,	tow_hknight_magica3	] {ai_face();};
void()	tow_hknight_magica3 =[	$magica3,	tow_hknight_magica4	] {ai_face();};
void()	tow_hknight_magica4 =[	$magica4,	tow_hknight_magica5	] {ai_face();};
void()	tow_hknight_magica5 =[	$magica5,	tow_hknight_magica6	] {ai_face();};
void()	tow_hknight_magica6 =[	$magica6,	tow_hknight_magica7	] {ai_face();};
void()	tow_hknight_magica7 =[	$magica7,	tow_hknight_magica8	] {tow_hknight_shot(-2);};
void()	tow_hknight_magica8 =[	$magica8,	tow_hknight_magica9	] {tow_hknight_shot(-1);};
void()	tow_hknight_magica9 =[	$magica9,	tow_hknight_magica10] {tow_hknight_shot(0);};
void()	tow_hknight_magica10 =[	$magica10,	tow_hknight_magica11] {tow_hknight_shot(1);};
void()	tow_hknight_magica11 =[	$magica11,	tow_hknight_magica12] {tow_hknight_shot(2);};
void()	tow_hknight_magica12 =[	$magica12,	tow_hknight_magica13] {tow_hknight_shot(3);};
void()	tow_hknight_magica13 =[	$magica13,	tow_hknight_magica14] {ai_face();};
void()	tow_hknight_magica14 =[	$magica14,	tow_hknight_stand1	] {ai_face();};

//============================================================================

void()	tow_hknight_magicb1 =[	$magicb1,	tow_hknight_magicb2	] {ai_face();};
void()	tow_hknight_magicb2 =[	$magicb2,	tow_hknight_magicb3	] {ai_face();};
void()	tow_hknight_magicb3 =[	$magicb3,	tow_hknight_magicb4	] {ai_face();};
void()	tow_hknight_magicb4 =[	$magicb4,	tow_hknight_magicb5	] {ai_face();};
void()	tow_hknight_magicb5 =[	$magicb5,	tow_hknight_magicb6	] {ai_face();};
void()	tow_hknight_magicb6 =[	$magicb6,	tow_hknight_magicb7	] {ai_face();};
void()	tow_hknight_magicb7 =[	$magicb7,	tow_hknight_magicb8	] {tow_hknight_shot(-2);};
void()	tow_hknight_magicb8 =[	$magicb8,	tow_hknight_magicb9	] {tow_hknight_shot(-1);};
void()	tow_hknight_magicb9 =[	$magicb9,	tow_hknight_magicb10] {tow_hknight_shot(0);};
void()	tow_hknight_magicb10 =[	$magicb10,	tow_hknight_magicb11] {tow_hknight_shot(1);};
void()	tow_hknight_magicb11 =[	$magicb11,	tow_hknight_magicb12] {tow_hknight_shot(2);};
void()	tow_hknight_magicb12 =[	$magicb12,	tow_hknight_magicb13] {tow_hknight_shot(3);};
void()	tow_hknight_magicb13 =[	$magicb13,	tow_hknight_stand1] {ai_face();};

//============================================================================

void()	tow_hknight_magicc1 =[	$magicc1,	tow_hknight_magicc2	] {ai_face();};
void()	tow_hknight_magicc2 =[	$magicc2,	tow_hknight_magicc3	] {ai_face();};
void()	tow_hknight_magicc3 =[	$magicc3,	tow_hknight_magicc4	] {ai_face();};
void()	tow_hknight_magicc4 =[	$magicc4,	tow_hknight_magicc5	] {ai_face();};
void()	tow_hknight_magicc5 =[	$magicc5,	tow_hknight_magicc6	] {ai_face();};
void()	tow_hknight_magicc6 =[	$magicc6,	tow_hknight_magicc7	] {tow_hknight_shot(-2);};
void()	tow_hknight_magicc7 =[	$magicc7,	tow_hknight_magicc8	] {tow_hknight_shot(-1);};
void()	tow_hknight_magicc8 =[	$magicc8,	tow_hknight_magicc9	] {tow_hknight_shot(0);};
void()	tow_hknight_magicc9 =[	$magicc9,	tow_hknight_magicc10] {tow_hknight_shot(1);};
void()	tow_hknight_magicc10 =[	$magicc10,	tow_hknight_magicc11] {tow_hknight_shot(2);};
void()	tow_hknight_magicc11 =[	$magicc11,	tow_hknight_stand1] {tow_hknight_shot(3);};

//===========================================================================

void()	tow_hknight_char_a1	=[	$char_a1,	tow_hknight_char_a2	] { };
void()	tow_hknight_char_a2	=[	$char_a2,	tow_hknight_char_a3	] { };
void()	tow_hknight_char_a3	=[	$char_a3,	tow_hknight_char_a4	] { };
void()	tow_hknight_char_a4	=[	$char_a4,	tow_hknight_char_a5	] { };
void()	tow_hknight_char_a5	=[	$char_a5,	tow_hknight_char_a6	] { };
void()	tow_hknight_char_a6	=[	$char_a6,	tow_hknight_char_a7	] {  ai_melee();};
void()	tow_hknight_char_a7	=[	$char_a7,	tow_hknight_char_a8	] {  ai_melee();};
void()	tow_hknight_char_a8	=[	$char_a8,	tow_hknight_char_a9	] {  ai_melee();};
void()	tow_hknight_char_a9	=[	$char_a9,	tow_hknight_char_a10	] {  ai_melee();};
void()	tow_hknight_char_a10=[	$char_a10,	tow_hknight_char_a11	] {  ai_melee();};
void()	tow_hknight_char_a11=[	$char_a11,	tow_hknight_char_a12	] {  ai_melee();};
void()	tow_hknight_char_a12=[	$char_a12,	tow_hknight_char_a13	] { };
void()	tow_hknight_char_a13=[	$char_a13,	tow_hknight_char_a14	] { };
void()	tow_hknight_char_a14=[	$char_a14,	tow_hknight_char_a15	] { };
void()	tow_hknight_char_a15=[	$char_a15,	tow_hknight_char_a16	] { };
void()	tow_hknight_char_a16=[	$char_a16,	tow_hknight_stand1	] { };

//===========================================================================

void()	tow_hknight_char_b1	=[	$char_b1,	tow_hknight_char_b2	] {
	CheckContinueCharge();
	 
	ai_melee();
};

void()	tow_hknight_char_b2	=[	$char_b2,	tow_hknight_char_b3	] {  ai_melee();};
void()	tow_hknight_char_b3	=[	$char_b3,	tow_hknight_char_b4	] {  ai_melee();};
void()	tow_hknight_char_b4	=[	$char_b4,	tow_hknight_char_b5	] {  ai_melee();};
void()	tow_hknight_char_b5	=[	$char_b5,	tow_hknight_char_b6	] {  ai_melee();};
void()	tow_hknight_char_b6	=[	$char_b6,	tow_hknight_char_b1	] {  ai_melee();};

//===========================================================================

void()	tow_hknight_slice1	=[	$slice1,	tow_hknight_slice2	] { };
void()	tow_hknight_slice2	=[	$slice2,	tow_hknight_slice3	] { };
void()	tow_hknight_slice3	=[	$slice3,	tow_hknight_slice4	] { };
void()	tow_hknight_slice4	=[	$slice4,	tow_hknight_slice5	] { };
void()	tow_hknight_slice5	=[	$slice5,	tow_hknight_slice6	] {  ai_melee();};
void()	tow_hknight_slice6	=[	$slice6,	tow_hknight_slice7	] {  ai_melee();};
void()	tow_hknight_slice7	=[	$slice7,	tow_hknight_slice8	] {  ai_melee();};
void()	tow_hknight_slice8	=[	$slice8,	tow_hknight_slice9	] {  ai_melee();};
void()	tow_hknight_slice9	=[	$slice9,	tow_hknight_slice10	] {ai_melee();};
void()	tow_hknight_slice10	=[	$slice10,	tow_hknight_stand1	] { };

//===========================================================================

void()	tow_hknight_smash1	=[	$smash1,	tow_hknight_smash2	] { };
void()	tow_hknight_smash2	=[	$smash2,	tow_hknight_smash3	] { };
void()	tow_hknight_smash3	=[	$smash3,	tow_hknight_smash4	] { };
void()	tow_hknight_smash4	=[	$smash4,	tow_hknight_smash5	] { };
void()	tow_hknight_smash5	=[	$smash5,	tow_hknight_smash6	] {  ai_melee();};
void()	tow_hknight_smash6	=[	$smash6,	tow_hknight_smash7	] {  ai_melee();};
void()	tow_hknight_smash7	=[	$smash7,	tow_hknight_smash8	] {  ai_melee();};
void()	tow_hknight_smash8	=[	$smash8,	tow_hknight_smash9	] {  ai_melee();};
void()	tow_hknight_smash9	=[	$smash9,	tow_hknight_smash10	] {  ai_melee();};
void()	tow_hknight_smash10	=[	$smash10,	tow_hknight_smash11	] { };
void()	tow_hknight_smash11	=[	$smash11,	tow_hknight_stand1	] { };

//============================================================================

void()	tow_hknight_watk1	=[	$w_attack1,	tow_hknight_watk2	] { };
void()	tow_hknight_watk2	=[	$w_attack2,	tow_hknight_watk3	] { };
void()	tow_hknight_watk3	=[	$w_attack3,	tow_hknight_watk4	] { };
void()	tow_hknight_watk4	=[	$w_attack4,	tow_hknight_watk5	] {ai_melee();};
void()	tow_hknight_watk5	=[	$w_attack5,	tow_hknight_watk6	] {ai_melee();};
void()	tow_hknight_watk6	=[	$w_attack6,	tow_hknight_watk7	] {ai_melee();};
void()	tow_hknight_watk7	=[	$w_attack7,	tow_hknight_watk8	] { };
void()	tow_hknight_watk8	=[	$w_attack8,	tow_hknight_watk9	] { };
void()	tow_hknight_watk9	=[	$w_attack9,	tow_hknight_watk10	] { };
void()	tow_hknight_watk10	=[	$w_attack10,	tow_hknight_watk11	] {  ai_melee();};
void()	tow_hknight_watk11	=[	$w_attack11,	tow_hknight_watk12	] {  ai_melee();};
void()	tow_hknight_watk12	=[	$w_attack12,	tow_hknight_watk13	] {  ai_melee();};
void()	tow_hknight_watk13	=[	$w_attack13,	tow_hknight_watk14	] { };
void()	tow_hknight_watk14	=[	$w_attack14,	tow_hknight_watk15	] { };
void()	tow_hknight_watk15	=[	$w_attack15,	tow_hknight_watk16	] { };
void()	tow_hknight_watk16	=[	$w_attack16,	tow_hknight_watk17	] { };
void()	tow_hknight_watk17	=[	$w_attack17,	tow_hknight_watk18	] {  ai_melee();};
void()	tow_hknight_watk18	=[	$w_attack18,	tow_hknight_watk19	] {  ai_melee();};
void()	tow_hknight_watk19	=[	$w_attack19,	tow_hknight_watk20	] {  ai_melee();};
void()	tow_hknight_watk20	=[	$w_attack20,	tow_hknight_watk21	] { };
void()	tow_hknight_watk21	=[	$w_attack21,	tow_hknight_watk22	] { };
void()	tow_hknight_watk22	=[	$w_attack22,	tow_hknight_stand1	] { };

//============================================================================


void(entity attacker, float damage)	tow_hknight_pain =
{
	if (self.pain_finished > time)
		return;

	sound (self, CHAN_VOICE, "hknight/pain1.wav", 1, ATTN_NORM);

	if (time - self.pain_finished > 5)
	{	// always go into pain frame if it has been a while
		tow_hknight_pain1 ();
		self.pain_finished = time + 1;
		return;
	}
	
	if ((random()*30 > damage) )
		return;		// didn't flinch

	self.pain_finished = time + 1;
	tow_hknight_pain1 ();
};

float	tow_hknight_type;

void() tow_hknight_melee =
{
	tow_hknight_type = tow_hknight_type + 1;

	sound (self, CHAN_WEAPON, "hknight/slash1.wav", 1, ATTN_NORM);
	if (tow_hknight_type == 1)
		tow_hknight_slice1 ();
	else if (tow_hknight_type == 2)
		tow_hknight_smash1 ();
	else if (tow_hknight_type == 3)
	{
		tow_hknight_watk1 ();
		tow_hknight_type = 0;
	}
};

/*QUAKED monster_hell_knight (1 0 0) (-16 -16 -24) (16 16 40) Ambush*/
void(vector org, entity tow_owner) monster_tow_hell_knight =
{
	local entity tower = spawn();
	
	tower.angles = vectoangles(aim(self, 1000));
	tower.angles_x =0;
	tower.angles_y =0;
	
	
	setorigin (tower, org + '0 0 50');
	
	tower.tower_upgrade_points = 0;
	tower.tower_upgrade_level = 3;
	
	tower.tower_owner = tow_owner;
	
	tower.solid = SOLID_SLIDEBOX;
	tower.movetype = MOVETYPE_STEP;

	setmodel (tower, "progs/hknight.mdl");

	tower.noise = "hknight/sight1.wav";
	tower.netname = "$qc_death_knight";
	tower.killstring = "$qc_ks_deathknight";

	setsize (tower, '-16 -16 -24', '16 16 40');
	tower.health = 250;
	tower.max_health = 250;

	tower.th_stand = tow_hknight_stand1;
	tower.th_walk = tow_hknight_walk1;
	tower.th_run = tow_hknight_run1;
	tower.th_melee = tow_hknight_melee;
	tower.th_missile = tow_hknight_magicc1;
	tower.th_pain = tow_hknight_pain;
	tower.th_die = tow_hknight_die;
	tower.allowPathFind = TRUE;
	tower.combat_style = CS_MIXED;
	
	sound (tower, CHAN_VOICE, tower.noise, 1, ATTN_NORM);
	turret_monster_init (tower);
};
