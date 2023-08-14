
//============================================================================

/*QUAKED monster_zombie (1 0 0) (-16 -16 -24) (16 16 32) Crucified ambush

If crucified, stick the bounding box 12 pixels back into a wall to look right.
*/
void() monster_tower =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}



	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/zombie.mdl");

	self.noise = "zombie/z_idle.wav";
	self.netname = "$qc_zombie";
	self.killstring = "$qc_ks_zombie";

	setsize (self, '-16 -16 -24', '16 16 40');
	self.health = 60;
	self.max_health = 60;

	self.th_stand = zombie_stand1;
	self.th_walk = zombie_walk1;
	self.th_run = zombie_run1;
	self.th_pain = zombie_pain;
	self.th_die = zombie_die;
	self.th_missile = zombie_missile;
	self.allowPathFind = TRUE;
	self.combat_style = CS_RANGED;

	if (self.spawnflags & SPAWN_CRUCIFIED)
	{
		self.movetype = MOVETYPE_NONE;
		zombie_cruc1 ();
	}
	else
		walkmonster_start();
};
