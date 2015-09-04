package com {
	import flash.display.Sprite;
	
	public class Runnable extends Sprite {
		public function run():void {
			throw new Error("Override Me");
		}
	}
}