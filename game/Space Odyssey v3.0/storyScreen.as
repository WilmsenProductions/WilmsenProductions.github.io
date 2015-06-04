package  
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author tim
	 */
	public class storyScreen extends MovieClip 
	{
		public var mcBack:SimpleButton;
		
		public function storyScreen() 
		{
			mcBack.addEventListener(MouseEvent.CLICK, startClick)
		}
		
		private function startClick(e:MouseEvent):void 
		{
			this.visible = false;
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