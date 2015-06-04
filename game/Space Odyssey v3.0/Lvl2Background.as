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
	public class Lvl2Background extends MovieClip 
	{
		
		public function Lvl2Background() 
		{
			
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