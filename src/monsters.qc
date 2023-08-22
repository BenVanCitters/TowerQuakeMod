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

/* ALL MONSTERS SHOULD BE 1 0 0 IN COLOR */

// name =[framenum,	nexttime, nextthink] {code}
// expands to:
// name ()
// {
//		self.frame=framenum;
//		self.nextthink = time + nexttime;
//		self.think = nextthink
//		<code>
// };


/*
================
monster_use

Using a monster makes it angry at the current activator
================
*/
void() monster_use =
{
	if (self.enemy)
		return;

	if (self.health <= 0)
		return;

	if (activator.items & IT_INVISIBILITY)
		return;

	if (activator.flags & FL_NOTARGET)
		return;

	if (activator.classname != "player")
		return;
	
	// delay reaction so if the monster is teleported, its sound is still heard
	self.enemy = activator;
	bprint("setting enemy monster_use\n");
	self.nextthink = time + 0.1;
	self.think = FoundTarget;
};

/*
================
monster_death_use

When a mosnter dies, it fires all of its targets with the current
enemy as activator.
================
*/
void() monster_death_use =
{
	// fall to ground
	if (self.flags & FL_FLY)
		self.flags = self.flags - FL_FLY;
	
	if (self.flags & FL_SWIM)
		self.flags = self.flags - FL_SWIM;

	if (!self.target)
		return;

	activator = self.enemy;
	SUB_UseTargets ();
};


//============================================================================

void() walkmonster_start_go =
{
	self.origin_z = self.origin_z + 1;	// raise off floor a bit
	droptofloor();
	
	if (!walkmove(0,0))
	{
		dprint ("walkmonster in wall at: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}
	
	self.takedamage = DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';

	if (!self.yaw_speed)
		self.yaw_speed = 20;

	self.view_ofs = '0 0 25';
	self.use = monster_use;
	self.team = TEAM_MONSTERS;
	self.flags = self.flags | FL_MONSTER;
	
	if (self.target != string_null)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);

		if (!self.movetarget)
		{
			dprint ("Monster can't find target at ");
			dprint (vtos(self.origin));
			dprint ("\n");
		}
	// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();

		else
			self.pausetime = 99999999;
			self.th_stand ();
	}

	else
	{
		local entity localclient = find(world, classname, "player");// checkclient ();
		
		bprint("I'm a ");
		bprint(self.classname);
		bprint(" and my check client was a ");
		bprint(localclient.classname);
		bprint(" der der der\n");
		if(localclient.classname == "player")
		{
			bprint("walking to 'client'\n");
			self.goalentity = self.movetarget = localclient;
			self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
			self.th_walk ();

		}
		else
		{
			self.pausetime = 99999999;
			self.th_stand ();
		}
	}

	// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
};



void (  ) turret_monster_think =
{
	self.origin_z = self.origin_z + 1;	// raise off floor a bit
	droptofloor();
	//dprint ("turret_monster_think");
	//if (!walkmove(0,0))
	//{
	//	dprint ("walkmonster in wall at: ");
	//	dprint (vtos(tower.origin));
	//	dprint ("\n");
	//}
	
	self.takedamage = DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';

	if (!self.yaw_speed)
		self.yaw_speed = 20;

	self.view_ofs = '0 0 25';
	self.use = monster_use;
	self.team = TEAM_MONSTERS;
	self.flags = self.flags | FL_MONSTER;
	
	self.pausetime = 99999999;
	self.th_stand ();
	
	// spread think times so they don't all happen at same time
	//self.nextthink = self.nextthink + random()*0.5;
};

void ( entity tower ) turret_monster_init =
{
	//dprint ("turret_monster_init");
	tower.nextthink = tower.nextthink + random()*0.5;
	tower.think = turret_monster_think;
	
}
void() walkmonster_start =
{
	//if the monsters start looking for the player too soon they wont 
	//find the player - for some reason - wait 1.5 seconds so the 'player'
	// is there for sure.
	local float start_delay = 1.5;
	if( time > 10)
	{
		start_delay = 0;
	}
	// delay drop to floor to make sure all doors have been spawned
	// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + start_delay +random()*0.5;
	self.think = walkmonster_start_go;
	total_monsters = total_monsters + 1;
};



void() flymonster_start_go =
{
	self.takedamage = DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';

	if (!self.yaw_speed)
		self.yaw_speed = 10;

	self.view_ofs = '0 0 25';
	self.use = monster_use;
	self.team = TEAM_MONSTERS;
	self.flags = self.flags | FL_FLY;
	self.flags = self.flags | FL_MONSTER;

	if (!walkmove(0,0))
	{
		dprint ("flymonster in wall at: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}

	if (self.target != string_null)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);

		if (!self.movetarget)
		{
			dprint ("Monster can't find target at ");
			dprint (vtos(self.origin));
			dprint ("\n");
		}
		// this used to be an objerror
		if (self.movetarget.classname == "path_corner")
			self.th_walk ();

		else
			self.pausetime = 99999999;
			self.th_stand ();
	}

	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}
};

void() flymonster_start =
{
	// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
	self.think = flymonster_start_go;
	total_monsters = total_monsters + 1;
};


void() swimmonster_start_go =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}

	self.takedamage = DAMAGE_AIM;

	self.ideal_yaw = self.angles * '0 1 0';

	if (!self.yaw_speed)
		self.yaw_speed = 10;

	self.view_ofs = '0 0 10';
	self.use = monster_use;
	self.team = TEAM_MONSTERS;	
	self.flags = self.flags | FL_SWIM;
	self.flags = self.flags | FL_MONSTER;

	if (self.target != string_null)
	{
		self.goalentity = self.movetarget = find(world, targetname, self.target);

		if (!self.movetarget)
		{
			dprint ("Monster can't find target at ");
			dprint (vtos(self.origin));
			dprint ("\n");
		}
		// this used to be an objerror
		self.ideal_yaw = vectoyaw(self.goalentity.origin - self.origin);
		self.th_walk ();
	}

	else
	{
		self.pausetime = 99999999;
		self.th_stand ();
	}

	// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random()*0.5;
};

void() swimmonster_start =
{
	// spread think times so they don't all happen at same time
	self.nextthink = self.nextthink + random() * 0.5;
	self.think = swimmonster_start_go;
	total_monsters = total_monsters + 1;
};


