package  
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author tim
	 */
	public class instructionsScreen extends MovieClip 
	{
		public var mcPlay:SimpleButton;
		
		public function instructionsScreen() 
		{
			mcPlay.addEventListener(MouseEvent.CLICK, startClick)
		}
		
		private function startClick(e:MouseEvent):void 
		{
			this.visible = false;
		}
	}

}