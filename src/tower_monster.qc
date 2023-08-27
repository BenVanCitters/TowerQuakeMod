//
// monster stuff
//
void(entity myEntity) nonRespawn={};

void() newMonsterSpawn =
{
	//if there is something at the spawn don't do anything...
	traceline(self.origin - '0 1 0', self.origin + '0 1 0', FALSE, self);
	if(trace_ent == world)
	{
		local entity new_enemy = spawn();
		//copy origin and angles in from the map entity settings
		new_enemy.owner = self;
		new_enemy.origin = self.origin;
		new_enemy.angles = self.angles;	
		self.monster_respawn(new_enemy);
		
		//instead of just calling 'walkmonsterstart' we use 'think' to properly set self
		new_enemy.think = self.monster_init_ai;
		new_enemy.nextthink = time + 0.1;	
	}	
	
	self.think = newMonsterSpawn;
	self.nextthink = time + self.respawn_wait;
}

void() kickoffMonster =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	
	self.monster_precaches();
	
	local entity monster_spawner = spawn();
	
	//assume these are set prior...
	monster_spawner.respawn_wait = self.respawn_wait;
	monster_spawner.origin = self.origin;
	monster_spawner.angles = self.angles;
	
	monster_spawner.think = newMonsterSpawn;
	monster_spawner.nextthink = time + 0.1;
	
	monster_spawner.monster_respawn = self.monster_respawn;
	monster_spawner.monster_init_ai = self.monster_init_ai;
	
	monster_spawner.monster_respawn(self);
	
	self.think = self.monster_init_ai;
	self.nextthink = time + 0.1;
}