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
	public class mcStartGameScreen extends MovieClip 
	{
		public var mcStart:SimpleButton;
		public var mcInstructions:SimpleButton;
		public var mcStory:SimpleButton;
		public var MenuInstructions:instructionsScreen;
		public var MenuStory:storyScreen;
		
		public function mcStartGameScreen() 
		{
			mcStart.addEventListener(MouseEvent.CLICK, startClick)
			mcInstructions.addEventListener(MouseEvent.CLICK, instructionsClick)
			mcStory.addEventListener(MouseEvent.CLICK, storyClick)
			MenuInstructions.visible = false;
			MenuStory.visible = false;
		}
		
		private function storyClick(e:MouseEvent):void 
		{
			MenuStory.visible = true;
		}
		
		private function instructionsClick(e:MouseEvent):void 
		{
			MenuInstructions.visible = true;
		}
		
		private function startClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("START_GAME"));
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