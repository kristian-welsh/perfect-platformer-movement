package com {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Main extends Sprite {
		private const STAGE_HEIGHT:uint = 600;
		private const GRAVITY:Number = 0.5;
		private const SPEED:Number = 0.2;
		private const X_VELOCITY_CAP:uint = 8;
		private const Y_VELOCITY_CAP:uint = 10;
		
		private var guy:MovieClip;
		private var leftPressed:Boolean = false;
		private var rightPressed:Boolean = false;
		private var grounded:Boolean = false;
		private var slowing:Boolean = false;
		private var xVelocity:Number = 0;
		private var yVelocity:Number = 0;
		
		public function Main() {
			super();
			createGuy();
			addEventListener(Event.ADDED_TO_STAGE, addListeners);
		}
		
		private function createGuy():void {
			guy = new MovieClip();
			guy.graphics.beginFill(0xDD0000);
			guy.graphics.drawRect(0, 0, 40, 40);
			guy.graphics.endFill();
			guy.x = 200;
			guy.y = 50;
			addChild(guy);
		}
		
		private function addListeners(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addListeners);
			stage.addEventListener(Event.ENTER_FRAME, tick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, registerKeydown);
			stage.addEventListener(KeyboardEvent.KEY_UP, registerKeyup);
		}
		
		private function tick(event:Event):void {
			if(guyWillLand())
				landHim();
			calculateVelocity();
			stopSlowingIfMotionless();
			guy.x += xVelocity;
			guy.y += yVelocity;
		}
		
		private function landHim():void {
			guy.y = STAGE_HEIGHT - guy.height;
			grounded = true;
			yVelocity = 0;
			stopIfTurning();
		}
		
		private function stopIfTurning():void {
			if((xVelocity > 0 && leftPressed) || (xVelocity < 0 && rightPressed) || (!leftPressed && !rightPressed))
				stopHim();
		}
		
		private function guyWillLand():Boolean {
			return guy.y + guy.height + yVelocity >= STAGE_HEIGHT;
		}
		
		private function calculateVelocity():void {
			if(!grounded)
				yVelocity += GRAVITY;
			if(leftPressed && xVelocity >= -X_VELOCITY_CAP)
				xVelocity -= SPEED;
			if(rightPressed && xVelocity <= X_VELOCITY_CAP)
				xVelocity += SPEED;
			if(slowing)
				xVelocity /= 1.2;
		}
		
		private function stopSlowingIfMotionless():void {
			if(slowing && Math.abs(xVelocity) < 0.1) {
				slowing = false;
				xVelocity = 0;
			}
		}
		
		private function registerKeydown(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37:
					leftPressed = true;
					break;
				case 39:
					rightPressed = true;
					break;
			}
		}
		
		private function registerKeyup(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37:
					if(grounded)
						stopHim();
					leftPressed = false;
					break;
				case 38:
					jump();
					break;
				case 39:
					if(grounded)
						stopHim();
					rightPressed = false;
					break;
			}
		}
		
		private function stopHim():void {
			slowing = true;
		}
		
		private function jump():void {
			grounded = false;
			yVelocity = -10;
		}
	}
}
