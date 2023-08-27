

//
// weapon stuff
//
.entity staticReticule;

void() hideReticuleTower=
{
	if( self.staticReticule )
	{
		// erase the model 
		setmodel(self.staticReticule, "");
	}
}

// We already have a valid trace for this new spawn
vector() getSpawnPosForCollision =
{
	local vector verticalOffset = VEC_HULL_MIN;
	verticalOffset_x = 0;
	verticalOffset_y = 0;
	return (trace_endpos - verticalOffset);
}

void() drawTowerUnderReticule=
{
	makevectors (self.v_angle);
	local vector source = self.origin + '0 0 16';
	local vector end = source + v_forward*200;
	traceline (source, end, FALSE, self);
	
	local float traceDist = vlen(source - trace_endpos);
	if( !self.staticReticule )
	{
		self.staticReticule = spawn();
		
		self.staticReticule.solid = SOLID_NOT;
		self.staticReticule.alpha = .5;
	}
	if (trace_fraction < 1.0 && traceDist > 50 )
	{
		setmodel (self.staticReticule, "progs/soldier.mdl"); //show the model
		
		local vector myAngle = self.v_angle;
		myAngle_x = myAngle_z = 0; // zero out the x and z rotations		
		self.staticReticule.angles = myAngle;

		local vector spawnPos = getSpawnPosForCollision();
		setorigin(self.staticReticule, spawnPos);
	}
	else
	{
		// erase the model 
		hideReticuleTower();
		
	}
}

//should either add health or bump up the tower
//soldier -> enforcer -> ogre -> hellknight -> vore -> shambler 
void(vector org, entity tow_owner) monster_tow_enforcer;
void(vector org, entity tow_owner) monster_tow_ogre;
void(vector org, entity tow_owner) monster_tow_hell_knight;
void(vector org, entity tow_owner) monster_tow_shalrath;
void(vector org, entity tow_owner) monster_tow_shambler;
void(vector org, entity tow_owner) monster_tow_army;

void(vector) spawn_tfog;
void(entity tower) upgradeTower = 
{
	if(tower.tower_upgrade_level == 1 ) //"grunt -> enforcer"
	{
		monster_tow_enforcer(tower.origin, tower.tower_owner);		
	}
	else if(tower.tower_upgrade_level == 2 ) //"enforcer -> ogre"
	{
		monster_tow_ogre(tower.origin, tower.tower_owner);		
	}
	else if(tower.tower_upgrade_level == 3 ) //"ogre -> hellknight"
	{
		monster_tow_hell_knight(tower.origin , tower.tower_owner);		
	}
	else if(tower.tower_upgrade_level == 4 ) //"hellknight -> vore"
	{
		monster_tow_shalrath(tower.origin, tower.tower_owner);		
	}
	else if(tower.tower_upgrade_level == 5 ) //"vore -> shambler"
	{
		monster_tow_shambler(tower.origin, tower.tower_owner);		
	}
	spawn_tfog(tower.origin);
	T_Damage(tower, tower, tower, 10000);
}

void(entity tower) tower_checkUpgrade = 
{
	if(tower.tower_upgrade_points > 4)
	{
		tower.tower_upgrade_level += 1;
		tower.tower_upgrade_points = 0;
		upgradeTower(tower);
	}
}
