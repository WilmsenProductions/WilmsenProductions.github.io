package  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.system.fscommand;
	import flash.net.*;
	/**
	 * ...
	 * @author tim
	 */
	public class FirstGame extends MovieClip
	{
		
		public var Player:MovieClip
		
		private var leftKeyIsDown:Boolean;
		private var RightKeyIsDown:Boolean;
		
		private var aMissileArray:Array;
		private var aEnemyArray:Array;
		
		public var scoreTxt:TextField;
		public var ammoTxt:TextField;
		public var MenuEnd:EndGameScreen;
		public var menuAgain:EndGameScreen;
		public var MenuWin:WinGameScreen;
		public var Lvl2:Lvl2Background;
		
		private var MenuStart:mcStartGameScreen;
		
		
		private var nScore:Number;
		private var nAmmo:Number;
		private var tEnemyTimer:Timer;
		
		public function FirstGame() 
		{
			//Create a loader object
			var startLoader:Loader = new Loader();
			//add event listener to listen for the complete event
			startLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, startLoaded);
			//load our loader object
			startLoader.load(new URLRequest("startScreen.swf"));
		}
		
		public function startLoaded(e:Event):void 
		{
			MenuEnd.hideScreen();
			MenuWin.hideScreen();
			Player.visible = false;
			scoreTxt.visible = false;
			ammoTxt.visible = false;
			
			//get a reference to the loaded movieclip
			MenuStart = e.target.content as mcStartGameScreen;
			//listen for start game event
			MenuStart.addEventListener("START_GAME", playGameAgain);
			//add it to the stage
			addChild(MenuStart);
		}
		
		private function playGameAgain(e:Event):void 
		{
			
			//initialize variables
			aMissileArray = new Array();
			aEnemyArray = new Array();
			nScore = 0;
			nAmmo = 30;
			Player.x = 262,95
			Player.y = 323,30
			
			Player.visible = true;
			scoreTxt.visible = true;
			ammoTxt.visible = true;
			
			MenuStart.hideScreen();
			
			MenuEnd.addEventListener("PLAY_AGAIN", playGameAgain);
			MenuWin.addEventListener("PLAY_AGAIN", playGameAgain);
			MenuWin.addEventListener("NEXT_LEVEL", GameLevel2);
			
			MenuEnd.hideScreen();
			MenuWin.hideScreen();
			Lvl2.hideScreen();
			
			updateScoreText();
			updateAmmoText();
			
			//trace("First Game Loaded");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			stage.addEventListener(Event.ENTER_FRAME, gameLoop)
			
			//creat an timer object
			tEnemyTimer = new Timer(1000)
			//listen for the timer ticks/intervals
			tEnemyTimer.addEventListener(TimerEvent.TIMER, addEnemy)
			//start our timer
			tEnemyTimer.start();
			
		}
		
		private function GameLevel2(e:Event):void 
		{	
			//initialize variables
			aMissileArray = new Array();
			aEnemyArray = new Array();
			nScore = 0;
			nAmmo = 20;
			Player.x = 262,95
			Player.y = 323,30
			
			Player.visible = true;
			scoreTxt.visible = true;
			ammoTxt.visible = true;
			
			MenuStart.hideScreen();
			
			MenuEnd.addEventListener("PLAY_AGAIN", playGameAgain);
			MenuWin.addEventListener("PLAY_AGAIN", playGameAgain);
			MenuWin.addEventListener("NEXT_LEVEL", GameLevel2);
			
			MenuEnd.hideScreen();
			MenuWin.hideScreen();
			Lvl2.showScreen();
			MenuWin.mcNextLevel.visible = false;
			
			updateScoreText();
			updateAmmoText();
			
			//trace("First Game Loaded");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			
			stage.addEventListener(Event.ENTER_FRAME, gameLoop)
			
			//creat an timer object
			tEnemyTimer = new Timer(1000)
			//listen for the timer ticks/intervals
			tEnemyTimer.addEventListener(TimerEvent.TIMER, addEnemy)
			//start our timer
			tEnemyTimer.start();	
		}
		
		private function updateScoreText():void 
		{
			scoreTxt.text = "Score: " + nScore;
		}
		
		private function updateAmmoText():void 
		{
			ammoTxt.text = "Ammo: " + nAmmo;
		}
		
		
		private function addEnemy(e:TimerEvent):void 
		{
			//create a new enemy object
			var newEnemy:Enemy = new Enemy();
			//add enemy object to the stage
			stage.addChild(newEnemy);
			//add our new enemy to our enemy array collection
			aEnemyArray.push(newEnemy);
			//trace(aEnemyArray.length);
		}
		
		private function gameLoop(e:Event):void 
		{
			playerControl();
			clampPlayerToScreen();
			checkMissilesOffscreen();
			checkEnemiesOffScreen();
			checkMissilesHitsEnemy();
			checkEndGameCondition();
			
		}
		
		private function checkEndGameCondition():void 
		{
			//check if the player has 0 missiles left and theres 0 missiles on screen
			if (nAmmo == 0 && aMissileArray.length == 0)
			{
				
				//stop player movement
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				//hide the player
				Player.visible = false;
				//stop spawning enemies
				tEnemyTimer.stop();
				//clear the enemies currently on screen
				for each(var enemy:Enemy in aEnemyArray)
				{
					//destroy the enemy
					enemy.destroyEnemy();
					//remove the enemy from the enemy array
					aEnemyArray.splice(0, 1);
				}
				//stop the game loop
				if (aEnemyArray.length == 0)
				{
					stage.removeEventListener(Event.ENTER_FRAME, gameLoop);
				}
				//enemy.visible = false;
				enemy.visible = false;
				//show end game screen
				MenuEnd.showScreen();
				
			}
			
			if (nAmmo == 0 && nScore >= 15 && aMissileArray.length == 0)
			{
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				
				Player.visible = false;
				tEnemyTimer.stop();
				
				for each(var enemy:Enemy in aEnemyArray)
				{
					enemy.destroyEnemy();
					aEnemyArray.splice(0, 1);
				}
				
				if (aEnemyArray.length == 0)
				{
					stage.removeEventListener(Event.ENTER_FRAME, gameLoop);
				}
				enemy.visible = false;
				MenuWin.showScreen();
			}
			
		}
		
		private function checkMissilesHitsEnemy():void 
		{
			//loop through all our current missiles
			for (var i:int = 0; i < aMissileArray.length; i++)
			{
				//get our current missile in the loop
				var currentMissile:Missile = aMissileArray[i];
				
				//loop through all our missiles
				for (var j:int = 0; j < aEnemyArray.length; j++)
				{
					//get the current enemy in the j loop
					var currentEnemy:Enemy = aEnemyArray[j];
					
					//test if our current missile is hitting our current enemy
					if (currentMissile.hitTestObject(currentEnemy))
					{
						//create an explosion
						//create a new explosion movieclip
						var newExplosion:Explosion = new Explosion()
						//add our explosion to the stage
						stage.addChild(newExplosion)
						//position our explosion to our enemy
						newExplosion.x = currentEnemy.x;
						newExplosion.y = currentEnemy.y;
						
						//remove the missile
						currentMissile.destoryMissile()
						//remove the missile from our missile array
						aMissileArray.splice(i, 1);
						
						//remove the current enemy on the stage
						currentEnemy.destroyEnemy()
						//remove the current enemy from our array
						aEnemyArray.splice(j, 1)
						
						//add one to our score
						nScore++;
						updateScoreText();
					}
				}
			}
		}
		
		private function checkEnemiesOffScreen():void 
		{
			//loop through all our enemies
			for (var i:int = 0; i < aEnemyArray.length; i++)
			{
				//get current enemy in the loop
				var currentEnemy:Enemy = aEnemyArray[i];
				//if our enemy is moving left and our current enemy has gone past the left side of the stage
				if (currentEnemy.sDirection == "L" && currentEnemy.x < -(currentEnemy.width / 2))
				{
					//remove enemy from our array
					aEnemyArray.splice(i, 1);
					//remove our enemy from the stage
					currentEnemy.destroyEnemy();
					
				} else
				if (currentEnemy.sDirection == "R" && currentEnemy.x > (stage.stageWidth + currentEnemy.width / 2))
				{
					//remove enemy from our array
					aEnemyArray.splice(i, 1);
					//remove our enemy from the stage
					currentEnemy.destroyEnemy();
				}
			}
		}
		
		private function checkMissilesOffscreen():void 
		{
			//loop through all missiles array
			for (var i:int = 0; i < aMissileArray.length; i++)
			{
				//get the current missile in the loop
				var currentMissile:Missile = aMissileArray[i];
				//test if current missile is past the top of the screen
				if (currentMissile.y < 0)
				{
					//remove our missile from the array
					aMissileArray.splice(i, 1);
					//destroy our missile
					currentMissile.destoryMissile();
				}
			}
		}
		
		private function clampPlayerToScreen():void 
		{
			//If player is on left screen
			if (Player.x < Player.width/2)
			{
				//stop player to the left screen
				Player.x = Player.width/2;
			}
			//If player is on right screen
			if (Player.x > stage.stageWidth - (Player.width/2))
			{
				//stop player to the right screen
				Player.x = stage.stageWidth - (Player.width/2);
			}
		}
		
		private function playerControl():void 
		{
			//If left key is pressed
			if (leftKeyIsDown == true)
			{
				//move player to left
				Player.x -= 5;
			}
			
			//If right key is pressed
			if (RightKeyIsDown == true)
			{
				//move player to right
				Player.x += 5;
			}
				
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			
			//trace(e.keyCode)
			//if left key is released
			if (e.keyCode == 37)
			{
				//left key is released
				leftKeyIsDown = false;
			}
			//if right key is released
			if (e.keyCode == 39)
			{
				//Right key is released
				RightKeyIsDown = false;
			}
			//if space bar is releaed
			if (e.keyCode == 32)
			{
				
				
				//test if the player has a missile left to fire
				if (nAmmo > 0)
				{
					nAmmo--;
					updateAmmoText();
					//fire a missile
					fireMissile();
				}
				
			}
			
		}
		
		private function fireMissile():void 
		{
			//create new missile
			var newMissile:Missile = new Missile();
			//add missile object to the stage
			stage.addChild(newMissile);
			//position our missile object on top of player
			newMissile.x = Player.x + 15;
			newMissile.y = Player.y;
			//add new missile to missile array
			aMissileArray.push(newMissile);
			//trace(aMissileArray.length)
		}
		
		private function keyDown(e:KeyboardEvent):void
		{
			if (e.keyCode == 37)
			{
				//left key is pressed
				leftKeyIsDown = true;
			}
			
			if (e.keyCode == 39)
			{
				//Right key is pressed
				RightKeyIsDown = true;
			}
		}
		
	}

}