package com.keyboard {
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import kris.test.SuiteProvidingTestCase;
	
	public class KeyboardTest extends SuiteProvidingTestCase {
		private var dispatcher:EventDispatcher;
		private var keyboard:Keyboard;
		
		public function KeyboardTest(testMethod:String = null) {
			super([
				returns_false_to_queries_when_no_keys_pressed,
				returns_true_to_queries_when_key_held,
				returns_true_to_queries_after_key_released,
				records_each_key_seperately,
				cleanup_removes_key_down_listener_from_dispatcher,
				cleanup_removes_key_up_listener_from_dispatcher
				], testMethod);
		}
		
		override protected function setUp():void {
			dispatcher = new EventDispatcher();
			keyboard = new Keyboard(dispatcher);
		}
		
		public function returns_false_to_queries_when_no_keys_pressed():void {
			assertReleased(1);
		}
		
		public function returns_true_to_queries_when_key_held():void {
			press(1);
			assertPressed(1);
		}
		
		public function returns_true_to_queries_after_key_released():void {
			press(1);
			release(1);
			assertReleased(1);
		}
		
		public function records_each_key_seperately():void {
			press(1);
			press(2);
			release(1);
			assertPressed(2);
		}
		
		public function cleanup_removes_key_down_listener_from_dispatcher():void {
			keyboard.cleanUp();
			press(1);
			assertReleased(1);
		}
		
		public function cleanup_removes_key_up_listener_from_dispatcher():void {
			press(1);
			keyboard.cleanUp();
			release(1);
			assertPressed(1);
		}
		
		private function press(keyCode:uint):void {
			dispatcher.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, 0, keyCode));
		}
		
		private function release(keyCode:uint):void {
			dispatcher.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_UP, true, false, 0, keyCode));
		}
		
		private function assertPressed(keyCode:uint):void {
			assertTrue(isPressed(keyCode));
		}
		
		private function assertReleased(keyCode:uint):void {
			assertFalse(isPressed(keyCode));
		}
		
		private function isPressed(keyCode:uint):Boolean {
			return keyboard.isPressed(keyCode)
		}
	}
}