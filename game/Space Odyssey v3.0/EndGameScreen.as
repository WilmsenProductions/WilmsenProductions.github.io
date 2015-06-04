package  
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author tim
	 */
	public class EndGameScreen extends MovieClip 
	{
		public var mcPlayAgain:SimpleButton;
		
		public function EndGameScreen() 
		{
			mcPlayAgain.addEventListener(MouseEvent.CLICK, PlayAgain);
		}
		
		private function PlayAgain(e:MouseEvent):void 
		{
			dispatchEvent(new Event("PLAY_AGAIN"));
		}
		
		public function hideScreen():void
		{
			this.visible = false;
			
		}
		
		public function showScreen():void
		{
			this.visible = true;
		}
		
	}

}