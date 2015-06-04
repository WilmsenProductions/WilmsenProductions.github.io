package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author tim
	 */
	public class Missile extends Sprite 
	{
		
		public function Missile() 
		{
			//missile added to the stage
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			//run custom code
			init();
		}
		
		private function init():void 
		{
			addEventListener(Event.ENTER_FRAME, missileLoop)
		}
		
		private function missileLoop(e:Event):void 
		{
			this.y -= 10;
		}
		
		public function destoryMissile():void 
		{
			//remove the object from the stage
			parent.removeChild(this);
			//remove any event listeners
			removeEventListener(Event.ENTER_FRAME, missileLoop);
		}
		
	}

}