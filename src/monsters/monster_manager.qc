// inserts a spawn if it is closer than any of the existing spawners or there are less than 5 of them
void(entity listOwner, entity insertEnt) insertSpawn =
{
	local float entCount = 0;
	local entity lastNode = listOwner;
	local entity curNode = listOwner.nextSpawner;
	local float inserted = FALSE;
	//empty list case
	if( listOwner.nextSpawner == world )
	{
		listOwner.nextSpawner = insertEnt;
		insertEnt.nextSpawner = world;
		return;
	}

	local float maxSpawnerCount = 5;
	//walk the list and insert if less than anything, but only allow a max length
	while( curNode != world && entCount < maxSpawnerCount)
	{
		//insert before
		if( (curNode.distToPlayer > insertEnt.distToPlayer) && !inserted )
		{
			lastNode.nextSpawner = insertEnt;
			insertEnt.nextSpawner = curNode;
			inserted = TRUE;
			
		}
		lastNode = curNode;
		curNode = curNode.nextSpawner;
		entCount= entCount + 1;
	}

	//iterated whole list but list isn't too long yet..
	if(entCount < maxSpawnerCount  && !inserted )
	{
		lastNode.nextSpawner = insertEnt;
		//lastNode = lastNode.nextSpawner;
		insertEnt.nextSpawner = world;
	}
	else
	{
		//curNode is now 'world' or if not then the list is too long
		lastNode.nextSpawner = world;
	}
}

void(entity listOwner) printSpawnList =
{
	local float entCount = 0;
	local entity curNode = listOwner.nextSpawner;
	bprint(listOwner.classname);
	bprint("'s spawnlist: (");

	//empty list case
	if(listOwner.nextSpawner == world)
	{
		bprint("Empty!");
	}

	//walk the list and insert if less than anything, but only allow a length of 5
	while( curNode != world && entCount < 5)
	{
		bprint("Ent[");
		bprint(ftos(entCount));
		bprint("]: ");
		bprint(ftos(curNode.distToPlayer));
		bprint(", ");
		draw_line(listOwner.origin, curNode.origin, 192, 0.2, TRUE);	
		curNode = curNode.nextSpawner;
		
		entCount= entCount + 1;
	}
	bprint(")\n");

}

void( entity playerEnt  ) nearestSpawns=
{
	playerEnt.nextSpawner = world;
	local entity temp = playerEnt;

	temp = nextent(temp);

	local float t = 0;
	while(temp != playerEnt)
	{		
	
		// .nextSpawner; 
		// .distToPlayer;
		if(temp.classname == "monster_spawner")
		{
			t = t + 1;
			temp.distToPlayer = vlen( temp.origin - playerEnt.origin );
			insertSpawn(playerEnt, temp);			
		}
		temp = nextent(temp);	
	}
	// bprint("nearestspawn saw ");
	// bprint(ftos(t));
	// bprint(" monster spawners...\n");


	//printSpawnList(playerEnt);
	
	//local entity head = findradius(self.origin, 1000);
	//local entity last = self;
	//while (head)
	//{
	//	draw_line(last.origin, head.origin, 192, .2, TRUE);
	//	last = head;
	//	head = head.chain;
		
	//}
	
}


entity monsterManager;

float() getCurrentCountOfMonsters = 
{
	return 0;
}

void() managerThink=
{
	bprint("cur monster count: ");
	bprint(ftos(self.health));
	bprint("\n");
	monsterManager.nextthink = time + 0.1;	
}

entity() makeMonsterManager=
{
	// bprint("Spawning the manager!\n");
	monsterManager = spawn();
	monsterManager.think = managerThink;
	monsterManager.nextthink = time + 0.1;	
	monsterManager.max_health = 5; // max enemies
	monsterManager.health = 0; //number of existing monsters - better to have a list?	
	return monsterManager;
}

entity() getMonsterManager =
{
	if(!monsterManager)
	{
		monsterManager = makeMonsterManager();		
	}
	else
	{
		
	// bprint("NOT Spawning the manager!\n");
	}
	return monsterManager;	
};

float() getLivingManagedMonsterCount=
{
	local entity mgr = getMonsterManager();
	return mgr.health;
}

void(entity monster) addLivingMonsterToManager=
{
	local entity mgr = getMonsterManager();
	mgr.health = mgr.health + 1;
}

void(entity monster) removeLivingMonsterFromManager=
{
	local entity mgr = getMonsterManager();
	mgr.health = mgr.health - 1;
}

void(entity player) processMonsterManagerForPlayer=
{
	
	local entity mgr = getMonsterManager();
	nearestSpawns(player);
	// for each
	local entity curNode = player.nextSpawner;
	//walk the list
	while( curNode != world )
	{
		if(curNode.nextthink < time && (mgr.health < mgr.max_health) )
		{
			curNode.nextthink = time + 2;
		
		}
	
		curNode = curNode.nextSpawner;
	}
}
