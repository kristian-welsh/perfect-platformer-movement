package com.keyboard {
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class Keyboard {
		static private const EMPTY_OBJECT:Object = {};
		
		static public const LEFT:uint = 37;
		static public const UP:uint = 38;
		static public const RIGHT:uint = 39;
		
		private var context:EventDispatcher;
		public var keys:Object;
		
		public function Keyboard(context:EventDispatcher) {
			this.context = context;
			keys = EMPTY_OBJECT;
			addListeners();
		}
		
		private function addListeners():void {
			context.addEventListener(KeyboardEvent.KEY_DOWN, registerKeyPress);
			context.addEventListener(KeyboardEvent.KEY_UP, registerKeyRelease);
		}
		
		private function registerKeyPress(e:KeyboardEvent):void {
			keys[e.keyCode] = true;
		}
		
		private function registerKeyRelease(e:KeyboardEvent):void {
			keys[e.keyCode] = false;
		}
		
		public function isPressed(number:uint):Boolean {
			return keys[number];
		}
		
		public function cleanUp():void {
			keys = EMPTY_OBJECT;
			removeListeners();
		}
		
		private function removeListeners():void {
			context.removeEventListener(KeyboardEvent.KEY_DOWN, registerKeyPress);
			context.removeEventListener(KeyboardEvent.KEY_UP, registerKeyRelease);
		}
	}
}