﻿package Scripts {	import Scripts.*;	import flash.events.Event;	import flash.display.MovieClip;	import flash.display.Stage;		public class Player extends MovieClip	{		var key:KeyObject;		var moveX:int = 0;		var moveY:int = 0;		var stageRef:Stage;		var speedX:int = 10;		var speedY:int = 10;		//var bullet:Fireball;		var commands:String = '';		var currentmove:int = 0;		var health = 1;		var theEngine:Engine;		var boss:Boss;		var fireBalls:Array;		var charArray:Array;		var charType:String;		var facingLeft:Boolean = true;		var falling:Boolean = true;		var fallingSpeed:Number = 1;		var fallingAcceleration:Number = 2;		var platformArray:Array;		var currentStanding = null;		var attacking:Boolean = false;				public function Player(myStage:Stage, myEngine:Engine, fireArray:Array, charSelect:String, platforms:Array) 		{			addEventListener(Event.ENTER_FRAME, loop);			stageRef = myStage;			theEngine = myEngine;			key = new KeyObject(myStage);			fireBalls = fireArray;			charType = charSelect;			platformArray = platforms;		}				public function giveBoss(theBoss:Boss)		{			boss = theBoss;		}				public function loop(event:Event)		{			checkForMovement();			movePlayer();			checkForFire();			checkForHits();		}				public function checkForFire()		{			var tempContainer;			var fireX:int;			var fireY:int = 0;						if (key.isDown(key.SPACE) && attacking == false)			{				if (charType == "earth")				{					earthAttack();				}			}			else if (attacking == true)			{				if (Inner.Attack.currentFrame >= Inner.Attack.totalFrames - 1)				{					if (facingLeft)					{						Inner.gotoAndStop(1);					}					else					{						Inner.gotoAndStop(2);					}					attacking = false;				}				else if (Inner.Attack.currentFrame == 7)				{					if (Inner.Attack.Hitbox.hitTestObject(boss))					{						boss.takeHit();					}				}			}		}				public function attack()		{			switch (charType)			{				case "earth":					earthAttack();					break;			}		}				public function earthAttack()		{			attacking = true;			if (facingLeft)			{				Inner.gotoAndStop(5);			}			else			{				Inner.gotoAndStop(6);			}		}				//movePlayer		public function movePlayer()		{			this.x += moveX;						if (moveX < 0)			{				facingLeft = true;				!attacking ? Inner.gotoAndStop(3) : null;				for (var current in platformArray)				{					while (this.hitTestObject(platformArray[current]))					{						this.x ++;					}					}			}			else if (moveX > 0)			{				facingLeft = false;				!attacking ? Inner.gotoAndStop(4) : null;				for (var current0 in platformArray)				{					while (this.hitTestObject(platformArray[current0]))					{						this.x --;					}					}			}			else if (facingLeft)			{				!attacking ? Inner.gotoAndStop(1) : null;			}			else			{				!attacking ? Inner.gotoAndStop(2) : null;			}			if (currentStanding != null)			{				if (this.x > currentStanding.x || this.x < currentStanding.x)				{					currentStanding = null;					falling = true;				}			}			if (charType != "pegasus" && falling)			{				fallingSpeed += fallingAcceleration;				moveY = fallingSpeed;			}			this.y += moveY;			while (this.x + this.width > stageRef.stageWidth)			{ 				this.x --;			}			while (this.x < 0)			{				this.x ++;			}			while (this.y + this.height > stageRef.stageHeight)			{ 				this.y --;				falling = false;			}			while (this.y < 0)			{				this.y ++;				fallingSpeed = 0;			}						if (moveY < 0)			{				for (var current1 in platformArray)				{					while (this.hitTestObject(platformArray[current1]))					{						this.y ++;						fallingSpeed = 0;					}					}			}			else if (moveY > 0)			{				for (var current2 in platformArray)				{					while (this.hitTestObject(platformArray[current2]))					{						this.y --;						fallingSpeed = 0;						falling = false;						currentStanding = platformArray[current2];					}					}			}					}				//checkForMovement		public function checkForMovement()		{			if (key.isDown(key.UP) && falling == false)			{				falling = true;				fallingSpeed = -30;			}			else if (key.isDown(key.DOWN) && charType == "pegasus")			{				moveY = speedY;			}			else			{				moveY = 0;			}			if (key.isDown(key.RIGHT))			{				moveX = speedX;			}			else if (key.isDown(key.LEFT))			{				moveX = -1 * speedX;			}			else			{				moveX = 0;			}					}		public function die()		{			removeEventListener(Event.ENTER_FRAME, loop);			this.parent.removeChild(this);		}				public function checkForHits()		{			if (health <= 0)			{				die();			}		}				public function takeHit(amount:int, type:String)		{			if (type == "laser")			{				health -= amount;			}		}	}	}