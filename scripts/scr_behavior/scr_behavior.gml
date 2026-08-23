global.Behavior = function(instance, team = "NeutralHitboxes") constructor {
	
	InputMode = -1 //0,1 (players 1 and 2), -1 (ai)
	Instance = instance
	Team = team
	
	WalkingSpeed = 50
	WalkingSpeedCurrent = 0
	WalkingAngle = 0
	WalkingAcceleration = 25
	WalkingSpeedTarget = 0
	
	Sprites = {}
	
	CurrentState = noone
	StateEnded = true
	FindNewState = true
	StateTimer = 0
	
	Height = 0 
	
	PickState = function() {
		
	}
	
	States = []
	
	Sprites = {

	}
	
	SetTeam = function(team="NeutralHitboxes") {
		self.Team = team
		array_push(struct_get(global.Teams,team).Hitboxes,self)
	}
	
	Draw = function () {
		set_depth_instance(self.Instance)
		
		//shadow
		draw_sprite_ext(spr_shadow,0,self.Instance.x,self.Instance.y,self.Instance.image_xscale*self.Instance.sprite_width/130,self.Instance.image_xscale*self.Instance.sprite_width/130,self.Instance.image_angle,c_black,self.Instance.image_alpha*0.25)
		
		
		draw_sprite_ext(self.Instance.sprite_index,self.Instance.image_index,self.Instance.x,self.Instance.y - self.Height,self.Instance.image_xscale,self.Instance.image_yscale,self.Instance.image_angle,self.Instance.image_blend,self.Instance.image_alpha)
	}
	
	Frame = function() {
		if StateEnded && FindNewState {
			StateTimer = 0
			self.PickState()
		}
		
		
		
		if CurrentState {
			CurrentState.Frame(self)
			
			if CurrentState.AllowMovement {
				if CurrentState.MovementBehavior == "chasePlayer" {
					if instance_exists(obj_player1) {
						self.WalkingAngle = point_direction(self.Instance.x,self.Instance.y,
						obj_player1.x,obj_player1.y)
						
						var distance = point_distance(self.Instance.x,self.Instance.y,
						obj_player1.x,obj_player1.y)
						
						if abs(distance-CurrentState.MovementVariable) < 5 { 
							self.WalkingSpeedTarget = 0
						}else if distance > CurrentState.MovementVariable  {
							self.WalkingSpeedTarget = 1
						} else {
							self.WalkingSpeedTarget = -1
						}
					}
				} else if CurrentState.MovementBehavior == "player1" {
					
					var walkingX = keyboard_check(ord("D"))-keyboard_check(ord("A"))
					var walkingY = keyboard_check(ord("S"))-keyboard_check(ord("W"))
					
					if walkingX != 0 || walkingY != 0 {
						self.WalkingAngle = point_direction(0,0,keyboard_check(ord("D"))-keyboard_check(ord("A"))
					,keyboard_check(ord("S"))-keyboard_check(ord("W")))
						self.WalkingSpeedTarget = 1
					} else {
						self.WalkingSpeedTarget = 0
					}
				}
				
				self.WalkingSpeedCurrent = scr_lerp(self.WalkingSpeedCurrent,
				self.WalkingSpeedTarget*self.WalkingSpeed
				,self.WalkingAcceleration)
				
				self.Instance.x += lengthdir_x(self.WalkingSpeedCurrent*delta(),self.WalkingAngle)
				self.Instance.y += lengthdir_y(self.WalkingSpeedCurrent*delta(),self.WalkingAngle)
				
				set_sprite_type_direction("Movement",self)
			}
		
		}
	}
}

function constructor_state() constructor {
	AllowMovement = true
	MovementMultiplier = 1
	
	
	Timer = 0
	
	AllowKnockback = true
	ShowWeapon = true
	
	
	MovementBehavior = "chasePlayer" //chaseEntities, wander, escapeEntities, player1
	MovementVariable = 0
	
	WeaponBehavior = "pointAtPlayer" //pointAtEntities, pointdown, mouse
	
	Frame = function(a) {
		
	}
	
	Start = function(a) {
	
	}
}

global.State = constructor_state


global.States = {}

global.States.Player1 = new constructor_state()
global.States.Player1.MovementBehavior = "player1"






global.States.General_Smash = function () : constructor_state() constructor {

	AllowMovement = false

	FallVelocity = 0
	Phase = 0

	PrepareTimer = 1
	PrepareFrameFunction = function() {}
	PrepareX = 0
	PrepareY = 0

	JumpForceY = 200
	JumpFrameFunction = function() {}
	JumpDrag = 500
	JumpHorizontalSnapLerp = 12
	JumpStretch = false
	JumpStretchValue = 1900

	LandTimer = 1
	LandFrameFunction = function() {}
	LandFunction = function() {}


	Start = function(a,XX = "none",YY = 0) {
		show_debug_message(self.Phase)
	
		if XX == "none"  {
			
			XX = 0  
			
			if instance_exists(obj_player1) {
				XX = obj_player1.x
				YY = obj_player1.y
			}
		}
		
		self.PrepareX = XX
		self.PrepareY = YY
	
		self.Phase = 0
		self.Timer = self.PrepareTimer
		self.FallVelocity = 0
	
		set_sprite_type_direction("Smash_Prepare",a)
	}

	Frame = function(a) {

		if self.Phase != 1 {
			self.Timer -= delta()
		
			if self.Timer <= 0 {
				self.Phase += 1
			
				if self.Phase == 1 {
					self.Timer = 1
					self.FallVelocity = self.JumpForceY
					set_sprite_type_direction("Smash_Jump",a)
				} else if Phase == 3 {
					a.StateEnded = true
				}
			}
		} else {
			self.JumpFrameFunction()
			
			self.FallVelocity -= delta()*self.JumpDrag
			a.Height = max(a.Height + self.FallVelocity*delta(),0)
			
			a.Instance.x = scr_lerp(a.Instance.x,self.PrepareX,self.JumpHorizontalSnapLerp)
			a.Instance.y = scr_lerp(a.Instance.y,self.PrepareY,self.JumpHorizontalSnapLerp)
			
			if self.JumpStretch {
				a.Instance.image_yscale = scr_lerp(a.Instance.image_yscale, 1+abs(self.FallVelocity/self.JumpStretchValue),20)
				a.Instance.image_xscale = 1/a.Instance.image_yscale
			}
		
			if a.Height == 0 {
				set_sprite_type_direction("Smash_Land",a)
				self.Phase += 1
				self.LandFunction()
				self.Timer = self.LandTimer
				a.Instance.image_yscale = 1
				a.Instance.image_xscale = 1
			}
		}
	
		if self.Phase == 0 {
			self.PrepareFrameFunction()
		} else if self.Phase == 2 {
			self.LandFrameFunction()
		}
	}
}
