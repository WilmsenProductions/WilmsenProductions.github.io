package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author tim
	 */
	public class Enemy extends MovieClip 
	{
		public var sDirection:String;
		
		private var nSpeed:Number;
		
		public function Enemy() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void 
		{
			//number of enemies per frame
			var nEnemies:Number = 3;
			//pick a random number between 1 and number of enemies
			var nRandom:Number = randomNumber(1, nEnemies);
			//setup our playhead of this enemy clip to our random number
			this.gotoAndStop(nRandom)
			//setup our enemys start position
			setupStartPosition();
			
		}
		
		private function setupStartPosition():void 
		{
			//pick a random speed for our enemy
			nSpeed = randomNumber(5, 10);
			//pick a random number for left or right starting position
			var nLeftOrRight:Number = randomNumber(1, 2);
			//if our nLeftOrRight == 1, make our enemy start on the left side
			if (nLeftOrRight == 1)
			{
				//start our enemy on the left side
				this.x = -( this.width / 2);
				sDirection = "R";
			} else 
			{
				//start our enemy on the right side
				this.x = stage.stageWidth + (this.width / 2);
				sDirection = "L";
			}
			//set a random altitude for our enemy
			//setup 2 variable for our min altitude and our max altitude
			var nMinAltitude:Number = stage.stageHeight / 2;
			var nMaxAltitude:Number = (this.height / 2);
			
			//setup our enemies altitude to a random point between our min and max altitudes
			this.y = randomNumber(nMinAltitude, nMaxAltitude);
			
			//move our enemy 
			startMoving();
		}
		
		private function startMoving():void 
		{
			addEventListener(Event.ENTER_FRAME, enemyLoop)
		}
		
		private function enemyLoop(e:Event):void 
		{
			//test direction our enemy is moving in
			//if our enemy is moving right
			if (sDirection == "R")
			{
				//move our enemy right
				this.x += nSpeed;
			} else
			{
				//move our enemy left
				this.x -= nSpeed;
			}
		}
		
		public function destroyEnemy():void 
		{
			//remove enemy from the stage
			if (this.parent) 
			{ 
				parent.removeChild(this); 
			}
			//remove any event listeners in our enemy object
			removeEventListener(Event.ENTER_FRAME, enemyLoop);
		}
		function  randomNumber(low:Number=0, high:Number=1):Number
		{
			return Math.floor(Math.random() * (1 + high - low)) + low;
		}
		
		
		
	}

}