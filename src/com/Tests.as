package com {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import org.flashdevelop.utils.FlashConnect;
	
	public class Tests {
		private var main:Main;
		private var stage:Stage;
		private var tests:Array = [];
		private var guy:DisplayObject;
		
		public function Tests(main:Main, stage:Stage):void {
			this.main = main;
			this.stage = stage;
			
			addTest(testGuyAddedCorrectly);
			addTest(testTickDropGuy);
			addTest(testBottomOfStageStopsGuyFalling);
			
			guy = main.getChildAt(0);
		}
		
		private function addTest(test:Function):void {
			tests.push(test);
		}
		
		// don't test purely graphical stuff.
		private function testGuyAddedCorrectly():void {
			assertEquals(1, main.numChildren);
			assertEquals(200, guy.x);
			assertEquals(50, guy.y);
		}
		
		private function testTickDropGuy():void {
			// y increases by previous increase + .5 each tick
			assertEquals(50, guy.y);
			tick();
			assertEquals(50.5, guy.y);
			tick();
			assertEquals(51.5, guy.y);
			tick();
			assertEquals(53, guy.y);
		}
		
		private function tick():void {
			stage.dispatchEvent(new Event(Event.ENTER_FRAME));
		}
		
		//  unfinished, no edge cases.
		private function testBottomOfStageStopsGuyFalling():void {
			guy.y = Main.STAGE_HEIGHT - Main.GUY_HEIGHT + 123;
			tick();
			assertGuyLanded();
		}
		
		private function assertGuyLanded():void {
			assertEquals(Main.STAGE_HEIGHT - Main.GUY_HEIGHT, guy.y);
		}
		
		private function assertGuyNotLanded():void {
			assertNotEquals(Main.STAGE_HEIGHT - Main.GUY_HEIGHT, guy.y);
		}
		
		private function assertEquals(expected:Object, actual:Object):void {
			if (expected !== actual)
				fail("Test Failed: assertEquals. Expected: " + expected + ", Actual: " + actual + ".");
		}
		
		private function assertNotEquals(expected:Object, actual:Object):void {
			if (expected === actual)
				fail("Test Failed: assertNotEquals. Expected: " + expected + ", Actual: " + actual + ".");
		}
		
		private function fail(message:String):void {
			throw new Error(message);
		}
		
		public function runAll():void {
			for each(var test:Function in tests)
				test();
		}
	}
}