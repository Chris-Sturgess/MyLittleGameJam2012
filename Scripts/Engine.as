﻿package Scripts{	import Scripts.*;	import flash.events.Event;	import flash.display.MovieClip;	import flash.display.Stage;	import flashx.textLayout.utils.CharacterUtil;	import flashx.textLayout.formats.Float;	public class Engine extends MovieClip	{		var mainPlayer:Player;		//var boss:Boss;		var container:MovieClip;		var fireArray:Array;		var laserArray:Array;		var bossDead:Boolean;		var bgLoop = new Background();		var t:int = 0;		var platformArray:Array = new Array();		public function Engine()		{			begin();		}				public function begin()		{			addEventListener(Event.ENTER_FRAME, beginloop);			init();		}		public function init()		{			fireArray = new Array();			laserArray = new Array();			mainPlayer = new Player(stage,this,fireArray,"earth", platformArray);			trace(mainPlayer);			container = new MovieClip;			container.addChild(bgLoop);			stage.addChild(container);			container.addChild(mainPlayer);			mainPlayer.x = 200;			mainPlayer.y = 200;			addEventListener(Event.ENTER_FRAME,loop);			initiatePlatforms();			for (var currentPlatform in platformArray)			{				container.addChild(platformArray[currentPlatform]);			}						/*boss = new Boss(stage,this,laserArray);			boss.x = stage.stageWidth - boss.width;			boss.y = stage.stageHeight / 2;			container.addChild(boss);			bossDead = false;*/		}		public function loop(event:Event)		{			checkChars();			checkBoss();			checkBullets();			if (bossDead)			{				cleanup();			}		}		public function checkBoss()		{			/*for (var i:int = fireArray.length - 1; i >= 0; i--)			{				if (fireArray[i].hitTestObject(boss))				{					boss.takeHit(10,"fire");					fireArray[i].die();				}			}*/		}		public function checkChars()		{			for (var i:int = 0; i < laserArray.length; i++)			{				if (laserArray[i].hitTestObject(mainPlayer))				{					mainPlayer.takeHit(10,"laser");				}			}		}		public function checkBullets()		{			for (var i:int = fireArray.length - 1; i >= 0; i--)			{				for (var j:int = 0; j < laserArray.length; j++)				{					if (fireArray[i] != undefined)					{						if (fireArray[i].hitTestObject(laserArray[j]))						{							fireArray[i].die();						}					}				}			}		}		public function cleanup()		{			for (var i:int = fireArray.length - 1; i >= 0; i--)			{				fireArray[i].die();			}			for (var k:int = laserArray.length - 1; k >= 0; k--)			{				laserArray[k].die();			}		}				public function beginloop(event:Event)		{			t++;		}				public function initiatePlatforms()		{			var newPlatform;			newPlatform = new Platform();			newPlatform.x = 100;			newPlatform.y = 100;			platformArray.push(newPlatform);			newPlatform = new Platform();			newPlatform.x = 100;			newPlatform.y = 300;			platformArray.push(newPlatform);			newPlatform = new Platform();			newPlatform.x = 100;			newPlatform.y = 500;			platformArray.push(newPlatform);			newPlatform = new Platform();			newPlatform.x = 100;			newPlatform.y = 700;			platformArray.push(newPlatform);			newPlatform = new Platform();			newPlatform.x = 350;			newPlatform.y = 100;			platformArray.push(newPlatform);			newPlatform = new Platform();			newPlatform.x = 350;			newPlatform.y = 300;			platformArray.push(newPlatform);			newPlatform = new Platform();			newPlatform.x = 350;			newPlatform.y = 500;			platformArray.push(newPlatform);			newPlatform = new Platform();			newPlatform.x = 350;			newPlatform.y = 700;			platformArray.push(newPlatform);		}	}}