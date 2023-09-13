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

//adds spawns to a player via the 'nextspawner' field
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

void() cullMonsters = 
{
	local entity temp = self;
	local float t =0;
	local entity removeEnt = world;
	temp = nextent(temp);
	while(temp != self)
	{		
		if(temp.flags & FL_MONSTER && !(temp.flags & FL_TOWER))
		{
			t =t +1;
			if(temp.minPlayerDistance > 2000 ||  // if the player is really far away
				 (!temp.canSeePlayer && temp.minPlayerDistance > 1200) || //if you can't see the player and are 1200 units away
				temp.lastSawPlayerTime < time - 12) //if you haven't seen the player for 20 seconds
			{ removeEnt = temp; }
			
			//reset frame
			temp.minPlayerDistance = 9999999;
			temp.canSeePlayer = FALSE;
		}

		temp = nextent(temp);	
		
		if(removeEnt != world)
		{
			// bprint("removing a monster too far away!\n");
			remove(removeEnt);
			removeLivingMonsterFromManager(removeEnt);

			removeEnt = world;
		}
	}
	

}

void() managerThink=
{
	cullMonsters();
	// bprint("cur monster h: ");
	// bprint(ftos(self.health));
	// bprint("\n");
	monsterManager.nextthink = time + 0.1;	
}

entity() makeMonsterManager=
{
	// bprint("Spawning the manager!\n");
	monsterManager = spawn();
	monsterManager.think = managerThink;
	monsterManager.nextthink = time + 0.1;	
	monsterManager.max_health = 15; // max enemies
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
	{ // bprint("NOT Spawning the manager!\n");
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
};

void(entity player) calcMonsterForPlayer
{
	local entity temp = player;

	temp = nextent(temp);
	while(temp != self)
	{		
		if(temp.flags & FL_MONSTER && !(temp.flags & FL_TOWER))
		{
			//set min dist
			local float dToPlayer = vlen( temp.origin - player.origin );
			if(dToPlayer < temp.minPlayerDistance)
			{
				temp.minPlayerDistance = dToPlayer;
			}

			// see can see player
			traceline(player.origin + player.view_ofs, 
				      temp.origin + temp.view_ofs, TRUE, player);
			temp.canSeePlayer = temp.canSeePlayer | (trace_fraction >= 1);

			if(temp.canSeePlayer)
				temp.lastSawPlayerTime = time;
		}
		temp = nextent(temp);	
	}

}

void(entity player) setNearestPlayerForSpawns=
{
	local entity curNode = player.nextSpawner;
	while( curNode != world )
	{
		curNode.aiment = player;
		curNode = curNode.nextSpawner;
	}
};

void(entity player) processMonsterManagerForPlayer=
{
	calcMonsterForPlayer(player);
	local entity mgr = getMonsterManager();
	
	//get list
	nearestSpawns(player);
	
	//set who to move towards after spawning 
	setNearestPlayerForSpawns(player);
	//walk the list
	local entity curNode = player.nextSpawner;
	while( curNode != world )
	{
		if(curNode.nextthink < time && (mgr.health < mgr.max_health) )
		{
			curNode.nextthink = time + 2;
		
		}
		curNode = curNode.nextSpawner;
	}
}
