package com.tests {
	import com.game.GameTest;
	import com.keyboard.KeyboardTest;
	import kris.test.TestSuiteCollector;
	
	public class TestCases extends TestSuiteCollector {
		public function TestCases() {
			super();
			includeTestsFrom(GameTest);
			includeTestsFrom(KeyboardTest);
		}
	}
}