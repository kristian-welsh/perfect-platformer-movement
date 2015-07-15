package com {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	public class Main extends Sprite {
		const STAGE_HEIGHT:uint = 400;
		const GRAVITY:Number = 0.5;
		const SPEED:Number = 0.2;
		const X_VELOCITY_CAP:uint = 8;
		const Y_VELOCITY_CAP:uint = 10;
		
		var leftPressed:Boolean = false;
		var rightPressed:Boolean = false;
		var grounded:Boolean = false;
		var slowing:Boolean = false;
		var xVelocity:Number = 0;
		var yVelocity:Number = 0;
		
		public function Main() {
			super();
			addEventListener(Event.ADDED_TO_STAGE, addListeners);
		}
		
		private function addListeners(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, addListeners);
			stage.addEventListener(Event.ENTER_FRAME, tick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, registerKeydown);
			stage.addEventListener(KeyboardEvent.KEY_UP, registerKeyup);
		}
		
		function tick(event:Event):void {
			if(guyWillLand())
				landHim();
			calculateVelocity();
			stopSlowingIfMotionless();
			guy.x += xVelocity;
			guy.y += yVelocity;
		}
		
		function landHim():void {
			guy.y = STAGE_HEIGHT - guy.height;
			grounded = true;
			yVelocity = 0;
			stopIfTurning();
		}
		
		function stopIfTurning():void {
			if((xVelocity > 0 && leftPressed) || (xVelocity < 0 && rightPressed) || (!leftPressed && !rightPressed))
				stopHim();
		}
		
		function guyWillLand():Boolean {
			return guy.y + guy.height + yVelocity >= STAGE_HEIGHT;
		}
		
		function calculateVelocity():void {
			if(!grounded)
				yVelocity += GRAVITY;
			if(leftPressed && xVelocity >= -X_VELOCITY_CAP)
				xVelocity -= SPEED;
			if(rightPressed && xVelocity <= X_VELOCITY_CAP)
				xVelocity += SPEED;
			if(slowing)
				xVelocity /= 1.2;
		}
		
		function stopSlowingIfMotionless():void {
			if(slowing && Math.abs(xVelocity) < 0.1) {
				slowing = false;
				xVelocity = 0;
			}
		}
		
		function registerKeydown(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37:
					leftPressed = true;
					break;
				case 39:
					rightPressed = true;
					break;
			}
		}
		
		function registerKeyup(event:KeyboardEvent):void {
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
		
		function stopHim():void {
			slowing = true;
		}
		
		function jump():void {
			grounded = false;
			yVelocity = -10;
		}
	}
}
