
//self is assumed to be the indicator
//self.owner - should be tower
//self.owner.tower_owner should be the player that made the tower
vector() getHUDOrientationPos =
{
	makevectors (self.owner.angles);
	local vector tower_up = v_up;
	
	makevectors (self.owner.tower_owner.angles);
	local vector tower_owner_left =  v_right;
	
	local vector result = tower_owner_left * self.dest_x + 
	                 tower_up * self.dest_z;
	return result;
}

.float statusShowTime;
.entity health1, health2, health3, health4, health5;

void() healthIconThink=
{
	local vector iconOffset = getHUDOrientationPos();
	setorigin (self, self.owner.origin + 
	                 iconOffset );
	
	self.nextthink = time + 0.1;
	self.think = healthIconThink;
	local float curHealthPct = self.owner.health/self.owner.max_health;
	if(time >= self.owner.statusShowTime || curHealthPct <= self.dmg)
	{
		self.health = 0;
		remove(self);
	}
}

entity(entity tower, vector pos, float minPct) makeHealthIcon =
{
	local entity helt= spawn ();
	helt.health = 1;
	helt.owner = tower;
	helt.movetype = MOVETYPE_NOCLIP;
	helt.solid = SOLID_NOT;
	helt.classname = "healthIcon";
	helt.dest = pos; // co opt 'dest' as a local coordinate space position 
	helt.dmg = minPct; //co opt 'dmg' as min health pct
	helt.angles = '90 0 0';
	//makevectors (self.v_angle);
	//missile.angles = vectoangles(missile.velocity);
	
	helt.nextthink = time + 0.1;
	helt.think = healthIconThink;

	setmodel (helt, "progs/zom_gib.mdl");
	setsize (helt, '0 0 0', '0 0 0');			
	return helt;
}

void(entity tower) showHealth =
{
	local float healthPct = tower.health / tower.max_health; // current / max

	//only spawn these things if their 'health'is zero (aka if they have been removed) 

	if((tower.health1.health == 0) && healthPct > 0)
	{
		tower.health1 = makeHealthIcon(tower, '-20 0 40', 0);
	}
	if((tower.health2.health == 0) && healthPct > .4)
	{
		tower.health2 = makeHealthIcon(tower, '-10 0 40', .4);
	}
	if((tower.health3.health == 0) && healthPct > .6)
	{
		tower.health3 = makeHealthIcon(tower, '-0 0 40', .6);
	}
	if((tower.health4.health == 0) && healthPct > .8)
	{		
		tower.health4 = makeHealthIcon(tower, '10 0 40', .8);
	}
	if((tower.health5.health == 0) && healthPct > .9)
	{
		tower.health5 = makeHealthIcon(tower, '20 0 40', .9);
	}
	
}



.entity upgrade1, upgrade2, upgrade3, upgrade4;
void() upgradeIconThink=
{
	local vector iconOffset = getHUDOrientationPos();
	setorigin (self, self.owner.origin + 
	                 iconOffset );
	
	self.nextthink = time + 0.1;
	self.think = upgradeIconThink;
	
	local float upgradePoints = self.dmg;
	if(time >= self.owner.statusShowTime || self.owner.tower_upgrade_points <= upgradePoints)
	{
		self.health = 0;
		remove(self);
	}
}

entity(entity tower, vector pos, float points) makeUpgradeIcon =
{
	local entity upgrade= spawn ();
	upgrade.health = 1;
	upgrade.owner = tower;
	upgrade.movetype = MOVETYPE_NOCLIP;
	upgrade.solid = SOLID_NOT;
	upgrade.classname = "upgradeIcon";
	upgrade.dest = pos; // co opt ;dest' as a local coordinate space position 
	upgrade.dmg = points; //co opt 'dmg' as min upgrade count
	upgrade.angles = '0 0 0';
	//makevectors (self.v_angle);
	//missile.angles = vectoangles(missile.velocity);
	
	upgrade.nextthink = time + 0.1;
	upgrade.think = upgradeIconThink;

	setmodel (upgrade, "progs/m_s_key.mdl");
	setsize (upgrade, '0 0 0', '0 0 0');			
	return upgrade;
}

void(entity tower) showUpgradeStatus =
{
//l	
//tower_upgrade_points; //points towards the next level
// tower_upgrade_level
	//only spawn these things if their 'health'is zero (aka if they have been removed) 

	if( (tower.upgrade1.health == 0) && tower.tower_upgrade_points > 0)
	{
		tower.upgrade1 = makeUpgradeIcon(tower, '-15 0 50', 0);
	}
	if((tower.upgrade2.health == 0) && tower.tower_upgrade_points > 1)
	{
		tower.upgrade2 = makeUpgradeIcon(tower, '-5 0 50', 1);
	}
	if((tower.upgrade3.health == 0) && tower.tower_upgrade_points > 2)
	{
		tower.upgrade3 = makeUpgradeIcon(tower, '5 0 50', 2);
	}
	if((tower.upgrade4.health == 0) && tower.tower_upgrade_points > 3)
	{
		tower.upgrade4 = makeUpgradeIcon(tower, '15 0 50', 3);
	}
	
}

void() reticuleOver =
{
	makevectors (self.v_angle);
	local vector source = self.origin + '0 0 16';
	traceline (source, source + v_forward*2000, FALSE, self);
	//draw_line(source, source + v_forward*2000, 246, 1, TRUE);

	if(trace_ent.takedamage)// && trace_ent.health > 0 && trace_ent.flags & FL_MONSTER)
	{
		
		trace_ent.statusShowTime = time + 1;
		showHealth(trace_ent);
		showUpgradeStatus(trace_ent);
	}
}