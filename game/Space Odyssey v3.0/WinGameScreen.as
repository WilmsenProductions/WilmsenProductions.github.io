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
	public class WinGameScreen extends MovieClip 
	{
		public var mcPlayAgainWinScreen:SimpleButton;
		
		public var mcNextLevel:SimpleButton;
		
		public function WinGameScreen() 
		{
			mcPlayAgainWinScreen.addEventListener(MouseEvent.CLICK, PlayAgainWinScreen);
			mcNextLevel.addEventListener(MouseEvent.CLICK, NextLevel);
		}
		
		private function NextLevel(e:MouseEvent):void 
		{
			dispatchEvent(new Event("NEXT_LEVEL"));
		}
		
		private function PlayAgainWinScreen(e:MouseEvent):void 
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