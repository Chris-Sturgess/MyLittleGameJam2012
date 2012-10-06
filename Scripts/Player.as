﻿package Scripts {	import Scripts.*;	import flash.events.Event;	import flash.display.MovieClip;	import flash.display.Stage;		public class Player extends MovieClip	{		var key:KeyObject;		var moveX:int = 0;		var moveY:int = 0;		var stageRef:Stage;		var speedX:int = 10;		var speedY:int = 10;		//var bullet:Fireball;		var commands:String = '';		var currentmove:int = 0;		var health = 1;		var theEngine:Engine;		//var boss:Boss;		var fireBalls:Array;		var charArray:Array;		var charType:String;		var facingLeft:Boolean = true;		var falling:Boolean = true;		var fallingSpeed:Number = 1;		var fallingAcceleration:Number = 2;		var platformArray:Array;		var currentStanding = null;				public function Player(myStage:Stage, myEngine:Engine, fireArray:Array, charSelect:String, platforms:Array) 		{			//boss = theBoss;			addEventListener(Event.ENTER_FRAME, loop);			stageRef = myStage;			theEngine = myEngine;			key = new KeyObject(myStage);			fireBalls = fireArray;			charType = charSelect;			platformArray = platforms;		}				public function loop(event:Event)		{			checkForMovement();			movePlayer();			checkForFire();			checkForHits();		}				public function checkForFire()		{			var tempContainer;			var fireX:int;			var fireY:int = 0;						if (key.isDown(key.SPACE))			{				/*				bullet = new Fireball(stageRef, fireX, fireY, fireBalls);				bullet.x = Inner.Hitbox.x * .3 + this.x;				bullet.y = Inner.Hitbox.y * .3 + this.y;				this.parent.addChild(bullet);				fireBalls.push(bullet);*/			}		}				public function attack()		{			switch (charType)			{				case "earth":					earthAttack();			}		}				public function earthAttack()		{					}				//movePlayer		public function movePlayer()		{			this.x += moveX;						if (moveX < 0)			{				facingLeft = true;				Inner.gotoAndStop(3);				for (var current in platformArray)				{					while (this.hitTestObject(platformArray[current]))					{						this.x ++;					}					}			}			else if (moveX > 0)			{				facingLeft = false;				Inner.gotoAndStop(4);				for (var current in platformArray)				{					while (this.hitTestObject(platformArray[current]))					{						this.x --;					}					}			}			if (facingLeft && moveX == 0)			{				Inner.gotoAndStop(1);			}			else if (moveX == 0)			{				Inner.gotoAndStop(2);			}			if (currentStanding != null)			{				if (this.x > currentStanding.x || this.x < currentStanding.x)				{					currentStanding = null;					falling = true;				}			}			if (charType != "pegasus" && falling)			{				fallingSpeed += fallingAcceleration;				moveY = fallingSpeed;			}			this.y += moveY;			while (this.x + this.width > stageRef.stageWidth)			{ 				this.x --;			}			while (this.x < 0)			{				this.x ++;			}			while (this.y + this.height > stageRef.stageHeight)			{ 				this.y --;				falling = false;			}			while (this.y < 0)			{				this.y ++;				fallingSpeed = 0;			}						if (moveY < 0)			{				facingLeft = true;				for (var current in platformArray)				{					while (this.hitTestObject(platformArray[current]))					{						this.y ++;						fallingSpeed = 0;					}					}			}			else if (moveY > 0)			{				facingLeft = false;				for (var current in platformArray)				{					while (this.hitTestObject(platformArray[current]))					{						this.y --;						fallingSpeed = 0;						falling = false;						currentStanding = platformArray[current];					}					}			}					}				//checkForMovement		public function checkForMovement()		{			if (key.isDown(key.UP) && falling == false)			{				falling = true;				fallingSpeed = -30;			}			else if (key.isDown(key.DOWN) && charType == "pegasus")			{				moveY = speedY;			}			else			{				moveY = 0;			}			if (key.isDown(key.RIGHT))			{				moveX = speedX;			}			else if (key.isDown(key.LEFT))			{				moveX = -1 * speedX;			}			else			{				moveX = 0;			}					}		public function die()		{			removeEventListener(Event.ENTER_FRAME, loop);			this.parent.removeChild(this);		}				public function checkForHits()		{			if (health <= 0)			{				die();			}		}				public function takeHit(amount:int, type:String)		{			if (type == "laser")			{				health -= amount;			}		}	}	}