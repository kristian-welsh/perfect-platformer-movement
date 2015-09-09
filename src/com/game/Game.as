package com.game {
	import com.guy.GuyView;
	import com.keyboard.Keyboard;
	import com.tests.Tests;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import org.flashdevelop.utils.FlashConnect;
	
	public class Game extends Sprite {
		static public const STAGE_HEIGHT:uint = 600;
		static public const GRAVITY:Number = 0.5;
		static public const SPEED:Number = 0.2;
		static public const X_VELOCITY_CAP:uint = 8;
		static public const Y_VELOCITY_CAP:uint = 10;
		
		private var guy:MovieClip;
		private var keyboard:Keyboard;
		private var grounded:Boolean = false;
		private var slowing:Boolean = false;
		private var xVelocity:Number = 0;
		private var yVelocity:Number = 0;
		
		public function startGame():void {
			assert(parent, "Game must have a parent in order to start.");
			keyboard = new Keyboard(parent);
			createGuy();
			parent.addEventListener(Event.ENTER_FRAME, tick);
		}
		
		private function createGuy():void {
			guy = new GuyView();
			addChild(guy);
		}
		
		private function leftPressed():Boolean {
			return keyboard.isPressed(Keyboard.LEFT);
		}
		
		private function upPressed():Boolean {
			return keyboard.isPressed(Keyboard.UP);
		}
		
		private function rightPressed():Boolean {
			return keyboard.isPressed(Keyboard.RIGHT);
		}
		
		private function tick(event:Event = null):void {
			landIfCloseToGround();
			jumpIfNeeded();
			slowIfNotMoving();
			stopSlowingIfMotionless();
			calculateVelocity();
			
			guy.x += xVelocity;
			guy.y += yVelocity;
		}
		
		private function landIfCloseToGround():void {
			if (guyWillLand())
				landGuy();
		}
		
		private function guyWillLand():Boolean {
			return guy.y + guy.height + yVelocity >= STAGE_HEIGHT;
		}
		
		private function landGuy():void {
			guy.y = STAGE_HEIGHT - guy.height;
			grounded = true;
			yVelocity = 0;
			stopIfTurning();
		}
		
		private function jumpIfNeeded():void {
			if (grounded && upPressed())
				jump();
		}
		
		private function slowIfNotMoving():void {
			if (grounded && !slowing) {
				if (!leftPressed() && !rightPressed())
					startSlowing();
			}
		}
		
		private function stopIfTurning():void {
			if (shouldBeSlowing())
				startSlowing();
		}
		
		private function shouldBeSlowing():Boolean {
			return (xVelocity > 0 && leftPressed()) || (xVelocity < 0 && rightPressed()) || (!leftPressed() && !rightPressed());
		}
		
		private function calculateVelocity():void {
			if (!grounded)
				yVelocity += GRAVITY;
			if (leftPressed() && xVelocity >= -X_VELOCITY_CAP)
				xVelocity -= SPEED;
			if (rightPressed() && xVelocity <= X_VELOCITY_CAP)
				xVelocity += SPEED;
			if (slowing)
				xVelocity /= 1.2;
		}
		
		private function stopSlowingIfMotionless():void {
			if (slowing && (Math.abs(xVelocity) < 0.1 || leftPressed() || rightPressed()) && !(leftPressed() && rightPressed()))
				stopSlowing();
		}
		
		private function stopSlowing():void {
			slowing = false;
			xVelocity = 0;
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
