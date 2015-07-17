package com {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import kris.test.SuiteProvidingTestCase;
	
	public class GameTest extends SuiteProvidingTestCase {
		private var game:Game;
		private var container:DisplayObjectContainer;
		private var guy:DisplayObject;
		
		public function GameTest(testMethod:String = null) {
			super([
				testGuyAddedCorrectly,
				testTickDropGuy,
				testBottomOfStageStopsGuyFalling
				], testMethod);
		}
		
		override protected function setUp():void {
			container = new MovieClip();
			game = new Game();
			container.addChild(game);
			game.startGame();
			guy = game.getChildAt(0);
		}
		
		// don't test purely graphical stuff.
		public function testGuyAddedCorrectly():void {
			assertEquals(1, game.numChildren);
			assertEquals(200, guy.x);
			assertEquals(50, guy.y);
		}
		
		public function testTickDropGuy():void {
			// y increases by previous increase + .5 each tick
			assertEquals(50, guy.y);
			tick();
			assertEquals(50.5, guy.y);
			tick();
			assertEquals(51.5, guy.y);
			tick();
			assertEquals(53, guy.y);
		}
		
		//  unfinished, no edge cases.
		public function testBottomOfStageStopsGuyFalling():void {
			guy.y = Game.STAGE_HEIGHT - Game.GUY_HEIGHT + 123;
			tick();
			assertGuyLanded();
		}
		
		private function tick():void {
			container.dispatchEvent(new Event(Event.ENTER_FRAME));
		}
		
		private function assertGuyLanded():void {
			assertEquals(Game.STAGE_HEIGHT - Game.GUY_HEIGHT, guy.y);
		}
		
		private function assertGuyNotLanded():void {
			if (Game.STAGE_HEIGHT - Game.GUY_HEIGHT == guy.y)
				fail("aaaaand you fail");
		}
	}
}