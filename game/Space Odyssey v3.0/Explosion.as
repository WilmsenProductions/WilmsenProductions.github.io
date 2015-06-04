package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author tim
	 */
	public class Explosion extends MovieClip 
	{
		
		public function Explosion() 
		{
			//check if our explosion has been added to the stage
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			init();
		}
		
		private function init():void 
		{
			addEventListener(Event.ENTER_FRAME, explosionLoop);
		}
		
		private function explosionLoop(e:Event):void 
		{
			//if our current frame is at the final (totalFrames)
			if (this.currentFrame == this.totalFrames)
			{
				
				//remove our explosion clip
				parent.removeChild(this)
				//remove our enterframe even listener
				removeEventListener(Event.ENTER_FRAME, explosionLoop);
			}
				
		}
		
	}

}