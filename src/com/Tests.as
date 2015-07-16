package com {
	import flash.display.Stage;
	
	public class Tests {
		private var main:Main;
		private var stage:Stage;
		
		public function Tests(main:Main, stage:Stage):void {
			this.main = main;
			this.stage = stage;
		}
		
		public function run():void {
			testGuyAdded();
		}
		
		private function testGuyAdded():void {
			assertEquals(1, main.numChildren);
		}
		
		private function assertEquals(expected:Object, actual:Object):void {
			if (expected !== actual)
				fail("assertEquals failed");
		}
		
		private function fail(message:String):void {
			throw new Error(message);
		}
	}
}