package com {
	import flash.display.MovieClip;
	
	public class Guy extends MovieClip {
		static public const RED:uint = 0xDD0000;
		static public const WIDTH:uint = 40;
		static public const HEIGHT:uint = 40;
		static public const GUY_STARTING_X:uint = 200;
		static public const GUY_STARTING_Y:uint = 50;
		
		public function Guy() {
			super();
			
			graphics.beginFill(RED);
			graphics.drawRect(0, 0, WIDTH, HEIGHT);
			graphics.endFill();
			
			x = GUY_STARTING_X;
			y = GUY_STARTING_Y;
		}
	}
}