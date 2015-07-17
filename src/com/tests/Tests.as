package com.tests {
	import asunit.textui.TestRunner;
	import flash.display.Sprite;
	
	public class Tests extends Sprite {
		private var testRunner:TestRunner = new TestRunner();
		
		public function Tests() {
			super();
			addChild(testRunner);
		}
		
		public function run():void {
			testRunner.start(TestCases);
		}
	}
}