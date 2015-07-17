package com {
	import com.tests.Tests;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Main extends Sprite {
		static public var STAGE:Stage;
		
		public function Main() {
			super();
			(stage) ? start() : addEventListener(Event.ADDED_TO_STAGE, start);
		}
		
		private function start(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, start);
			STAGE = stage;
			(CONFIG::debug) ? runTests() : startGame();
		}
		
		private function runTests():void {
			var tests:Tests = new Tests();
			stage.addChild(tests);
			tests.run();
		}
		
		private function startGame():void {
			var game:Game = new Game();
			stage.addChild(game);
			game.startGame();
		}
	}
}