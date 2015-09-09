package com.game {
	import com.game.Game;
	import com.guy.GuyView;
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
				test_guy_added_correctly,
				test_tick_drop_guy,
				test_touching_bottom_stage_stops_guy_falling,
				test_just_above_bottom_stage_at_start_stops_guy_falling,
				test_just_above_bottom_stage_after_acceleration_stops_guy_falling,
				test_above_bottom_stage_guy_keeps_falling
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
		public function test_guy_added_correctly():void {
			assertEquals(1, game.numChildren);
			assertEquals(200, guy.x);
			assertEquals(50, guy.y);
		}
		
		public function test_tick_drop_guy():void {
			// y increases by previous increase + .5 each tick
			assertEquals(50, guy.y);
			tick();
			assertEquals(50.5, guy.y);
			tick();
			assertEquals(51.5, guy.y);
			tick();
			assertEquals(53, guy.y);
		}
		
		public function test_touching_bottom_stage_stops_guy_falling():void {
			groundSnapsCorrectlyFor(0);
		}
		
		public function test_just_above_bottom_stage_at_start_stops_guy_falling():void {
			groundSnapsCorrectlyFor(- Game.GRAVITY);
		}
		
		public function test_just_above_bottom_stage_after_acceleration_stops_guy_falling():void {
			groundSnapsCorrectlyFor(- Game.GRAVITY - Game.GRAVITY * 2, true, 2);
		}
		
		public function test_above_bottom_stage_guy_keeps_falling():void {
			groundSnapsCorrectlyFor(- Game.GRAVITY - 0.00001, false);
		}
		
		private function groundSnapsCorrectlyFor(pos:Number, shouldLand:Boolean = true, numTicks:uint = 1):void {
			guy.y = Game.STAGE_HEIGHT - GuyView.HEIGHT + pos;
			for (var i:uint = 0; i < numTicks; i++)
				tick();
			(shouldLand) ? assertGuyLanded() : assertGuyNotLanded();
		}
		
		private function tick():void {
			container.dispatchEvent(new Event(Event.ENTER_FRAME));
		}
		
		private function assertGuyLanded():void {
			assertEquals(Game.STAGE_HEIGHT - GuyView.HEIGHT, guy.y);
		}
		
		private function assertGuyNotLanded():void {
			if (Game.STAGE_HEIGHT - GuyView.HEIGHT == guy.y)
				fail("aaaaand you fail");
		}
	}
}