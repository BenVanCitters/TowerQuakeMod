

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

float(vector start, vector end) getTraceDist=
{
	traceline( start, end, FALSE, self);
	return vlen( trace_endpos - start );
}

// We already have a valid trace for this new spawn - self should be the player
vector() getSpawnPosForSelf =
{
	local vector minsz = '-16 -16 -24';
	local vector maxsz = '16 16 40';
	
	// cube corners f/b front back l/u lower upper, l/r left right
	local vector ful, fll, fur, flr, bul, bll, bur, blr;
	
	makevectors (self.v_angle);
	local vector source = self.origin + '0 0 36'; //36 hels align the tower to the reticule
	local vector end = source + v_forward*2000 ;
	
	ful_x = minsz_x; ful_y = maxsz_y; ful_z = maxsz_z;
	fll_x = minsz_x; fll_y = maxsz_y; fll_z = minsz_z;
	fur = maxsz;
	flr_x = maxsz_x; flr_y = maxsz_y; flr_z = minsz_z;
	
	bul_x = minsz_x; bul_y = minsz_y; bul_z = maxsz_z;
	bll = minsz;
	bur_x = maxsz_x; bur_y = minsz_y; bur_z = maxsz_z;
	blr_x = maxsz_x; blr_y = minsz_y; blr_z = minsz_z;
	
	//draw_line( source+ful, end+ful, 255, .2, TRUE);
	//draw_line( source+fll, end+fll, 255, .2, TRUE);
	//draw_line( source+fur, end+fur, 255, .2, TRUE);
	//draw_line( source+flr, end+flr, 255, .2, TRUE);
	
	//draw_line( source+bul, end+bul, 255, .2, TRUE);
	//draw_line( source+bll, end+bll, 255, .2, TRUE);
	//draw_line( source+bur, end+bur, 255, .2, TRUE);
	//draw_line( source+blr, end+blr, 255, .2, TRUE);
	
	//project forward each vertex of the AABB and store the deets for the 
	// shortest projection
	local float minDist = 9999999999;
	local vector minOffset;
	local vector minNormal;
	local float curDist;
	curDist = getTraceDist( source+ful, end+ful);
	if(curDist < minDist) { minDist = curDist; minOffset = ful; minNormal = trace_plane_normal;}
	curDist = getTraceDist( source+fll, end+fll);
	if(curDist < minDist) { minDist = curDist; minOffset = fll; minNormal = trace_plane_normal; }
	curDist = getTraceDist( source+fur, end+fur);
	if(curDist < minDist) { minDist = curDist; minOffset = fur; minNormal = trace_plane_normal; }
	curDist = getTraceDist( source+flr, end+flr);
	if(curDist < minDist) { minDist = curDist; minOffset = flr; minNormal = trace_plane_normal; }
	
	curDist = getTraceDist( source+bul, end+bul);
	if(curDist < minDist) { minDist = curDist; minOffset = bul; minNormal = trace_plane_normal; }
	curDist = getTraceDist( source+bll, end+bll);
	if(curDist < minDist) { minDist = curDist; minOffset = bll; minNormal = trace_plane_normal; }
	curDist = getTraceDist( source+bur, end+bur);
	if(curDist < minDist) { minDist = curDist; minOffset = bur; minNormal = trace_plane_normal; }
	curDist = getTraceDist( source+blr, end+blr);
	if(curDist < minDist) { minDist = curDist; minOffset = blr; minNormal = trace_plane_normal; }
	
	local vector myorg = source + v_forward*minDist;
	//draw_bounds(myorg + minsz, myorg + maxsz, 79, .2, TRUE);
	
	//if we are on a wall...
	traceline(myorg + '0 0 1' , myorg +'0 0 -1000',TRUE, self);
	local float dot_prod = trace_plane_normal * minNormal;
	if(dot_prod < .3)
	{
		myorg = trace_endpos;// drop to ground
		myorg_z = myorg_z - minsz_z; //push up
	}
	
	return myorg;
}

float(vector spawnPos, vector traceStart, float traceFraction) isTowerSpawnPosValid=
{
	local float traceDist = vlen(traceStart - spawnPos);
	
	return (traceFraction < 1.0 && traceDist > 50 );
}

void() drawTowerUnderReticule=
{
	makevectors (self.v_angle);
	local vector source = self.origin + '0 0 16';
	local vector end = source + v_forward*200;
	local vector spawnPos = getSpawnPosForSelf();
	
	traceline (source, end, FALSE, self);
	
	
	local float traceDist = vlen(source - spawnPos);
	if( !self.staticReticule )
	{
		self.staticReticule = spawn();
		
		self.staticReticule.solid = SOLID_NOT;
		self.staticReticule.alpha = .5;
	}
	if (trace_fraction < 1.0 && traceDist > 60 )
	{
		//show the tower if valid placement
		setmodel (self.staticReticule, "progs/soldier.mdl"); //show the model
		
		local vector myAngle = self.v_angle;
		myAngle_x = myAngle_z = 0; // zero out the x and z rotations		
		self.staticReticule.angles = myAngle;
				
		setorigin(self.staticReticule, spawnPos);
	}
	else
	{
		//show 'invalid' indicator
		end = source + v_forward*10000;
		traceline (source, end, FALSE, self);
		setmodel (self.staticReticule, "progs/invulner.mdl"); //show the model
		setorigin(self.staticReticule, trace_endpos);
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
