//
// monster stuff
//
void(entity monster) addLivingMonsterToManager;
void(entity monster) removeLivingMonsterFromManager;
entity() getMonsterManager;

void(entity myEntity) nonRespawn={};

void() newMonsterSpawn =
{
	local entity mgr = getMonsterManager();
	//if there is something at the spawn don't do anything...
	// - the spawner i a collider and if there was a touch in the last .2 seconds, it must be occupied
	local float noTouch = time - self.attack_finished > 0.2;
	if(noTouch && (mgr.health < mgr.max_health) )
	{
		local entity new_enemy = spawn();
		//copy origin and angles in from the map entity settings
		new_enemy.owner = self;
		new_enemy.origin = self.origin;
		new_enemy.angles = self.angles;	
		
		//make sure we don't accidentally auto cull via monster mgr
		new_enemy.minPlayerDistance = 9999999;
		new_enemy.canSeePlayer = FALSE;
		new_enemy.lastSawPlayerTime = time;

		self.monster_respawn(new_enemy);

		setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
		addLivingMonsterToManager(new_enemy);
		//instead of just calling 'walkmonsterstart' we use 'think' to properly set self
		new_enemy.think = self.monster_init_ai;
		new_enemy.nextthink = time + 0.1;	
	}	
	
	//self.think = newMonsterSpawn;
	// self.nextthink = time + self.respawn_wait;
	//manager sets the nextthink... 
};

void() spawner_touch =
{
	self.attack_finished = time;
	// bprint("collider touched!\n");
};

void() kickoffMonster =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	
	self.monster_precaches();
	
	local entity monster_spawner = spawn();
	monster_spawner.attack_finished = -1;
	monster_spawner.classname = "monster_spawner";
	monster_spawner.solid = SOLID_TRIGGER;	
	monster_spawner.movetype = MOVETYPE_NONE;
	monster_spawner.owner = self;
	monster_spawner.touch = spawner_touch;
	//assume these are set prior...
	monster_spawner.respawn_wait = self.respawn_wait;
	monster_spawner.origin = self.origin;
	monster_spawner.angles = self.angles;
	
	monster_spawner.think = newMonsterSpawn;
	//monster_spawner.nextthink = time + 0.1;
	
	monster_spawner.monster_respawn = self.monster_respawn;
	monster_spawner.monster_init_ai = self.monster_init_ai;
	
	//monster_spawner.monster_respawn(self);
	
	self.think = self.monster_init_ai;
	//self.nextthink = time + 0.1;
};

//recycle entity - decrement manager counter
void() removeMonsterThink=
{	
	 
	remove(self);
};

//function to remove bodies from the game after a while
//called on last death frame..
void()	deathRemove = 
{ 
	if (!(self.flags & FL_TOWER))
		removeLivingMonsterFromManager(self);
	self.think = removeMonsterThink; 
	self.nextthink = time + 10 + random()*10;
};