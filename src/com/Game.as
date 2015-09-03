package com {
	import com.tests.Tests;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Game extends Sprite {
		static public const STAGE_HEIGHT:uint = 600;
		static public const GRAVITY:Number = 0.5;
		static public const SPEED:Number = 0.2;
		static public const X_VELOCITY_CAP:uint = 8;
		static public const Y_VELOCITY_CAP:uint = 10;
		
		static public const GUY_WIDTH:uint = 40;
		static public const GUY_HEIGHT:uint = 40;
		static public const GUY_STARTING_X:uint = 200;
		static public const GUY_STARTING_Y:uint = 50;
		static public const RED:uint = 0xDD0000;
		
		private var guy:MovieClip;
		private var leftPressed:Boolean = false;
		private var rightPressed:Boolean = false;
		private var grounded:Boolean = false;
		private var slowing:Boolean = false;
		private var xVelocity:Number = 0;
		private var yVelocity:Number = 0;
		
		public function startGame():void {
			assert(parent, "Game must have a parent in order to start.");
			createGuy();
			parent.addEventListener(Event.ENTER_FRAME, tick);
			parent.addEventListener(KeyboardEvent.KEY_DOWN, registerKeydown);
			parent.addEventListener(KeyboardEvent.KEY_UP, registerKeyup);
		}
		
		private function runTests():void {
			var tests:Tests = new Tests();
			stage.addChild(tests);
			tests.run();
		}
		
		private function createGuy():void {
			guy = new MovieClip();
			guy.graphics.beginFill(RED);
			guy.graphics.drawRect(0, 0, GUY_WIDTH, GUY_HEIGHT);
			guy.graphics.endFill();
			guy.x = GUY_STARTING_X;
			guy.y = GUY_STARTING_Y;
			addChild(guy);
		}
		
		private function tick(event:Event = null):void {
			if (guyWillLand())
				landHim();
			calculateVelocity();
			stopSlowingIfMotionless();
			guy.x += xVelocity;
			guy.y += yVelocity;
		}
		
		private function guyWillLand():Boolean {
			return guy.y + guy.height + yVelocity >= STAGE_HEIGHT;
		}
		
		private function landHim():void {
			guy.y = STAGE_HEIGHT - guy.height;
			grounded = true;
			yVelocity = 0;
			stopIfTurning();
		}
		
		private function stopIfTurning():void {
			if ((xVelocity > 0 && leftPressed) || (xVelocity < 0 && rightPressed) || (!leftPressed && !rightPressed))
				startSlowing();
		}
		
		private function calculateVelocity():void {
			if (!grounded)
				yVelocity += GRAVITY;
			if (leftPressed && xVelocity >= -X_VELOCITY_CAP)
				xVelocity -= SPEED;
			if (rightPressed && xVelocity <= X_VELOCITY_CAP)
				xVelocity += SPEED;
			if (slowing)
				xVelocity /= 1.2;
		}
		
		private function stopSlowingIfMotionless():void {
			if (slowing && Math.abs(xVelocity) < 0.1) {
				stopSlowing();
			}
		}
		
		private function stopSlowing():void {
			slowing = false;
			xVelocity = 0;
		}
		
		private function registerKeydown(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 37:
					leftPressed = true;
					break;
				case 39:
					rightPressed = true;
					break;
			}
		}
		
		private function registerKeyup(event:KeyboardEvent):void {
			switch (event.keyCode) {
				case 37:
					if (grounded)
						startSlowing();
					leftPressed = false;
					break;
				case 38:
					jump();
					break;
				case 39:
					if (grounded)
						startSlowing();
					rightPressed = false;
					break;
			}
		}
		
		private function startSlowing():void {
			slowing = true;
		}
		
		private function jump():void {
			grounded = false;
			yVelocity = -10;
		}
	}
}
