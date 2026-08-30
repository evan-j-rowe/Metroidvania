function scr_boss_eye_particles(X,Y) {
	var ins =  instance_create_depth(X,Y,0,obj_blankbulletasset)
			ins.BulletAsset.HeightVelocity = -1*irandom_range(-50,-150)
			ins.BulletAsset.PreformHeightGravity = true
			ins.BulletAsset.Speed = irandom_range(80,100)*0.7
			ins.BulletAsset.SpeedAdjustment = -70
			ins.BulletAsset.SpeedMinimum = 0
			ins.BulletAsset.Angle = irandom_range(0,360)
			ins.sprite_index = spr_hurtbox_eye_particles
			ins.image_xscale = random_range(0.2,1.2)
			ins.image_yscale = ins.image_xscale
			ins.image_speed = 0
			ins.image_index = irandom_range(1,ins.image_number)
			ins.image_angle = irandom_range(0,360)
			ins.BulletAsset.Lifetime = random_range(0.2,1)
}

//BOUNCING ATTACK
global.States.Boss_EyeBounce = new global.State()
global.States.Boss_EyeBounce.AllowMovement = false
global.States.Boss_EyeBounce.NextState = noone
global.States.Boss_EyeBounce.Start = function(a,nextState,timer = 3) {
	self.CurrentType = "initialDrop" //bouncing
	self.BouncesCount = 1
	self.FallVelocity = 0
	self.TargetX = 0
	self.TargetY = 0
}

global.States.Boss_EyeBounce.Frame = function(a) {
	self.FallVelocity += delta()*(100)
	a.Height = max(a.Height - self.FallVelocity*delta(),0)
	
	if self.CurrentType == "bouncing" {
		a.Instance.image_yscale = scr_lerp(a.Instance.image_yscale, 1+abs(self.FallVelocity/1900),20)
		a.Instance.image_xscale = 1/a.Instance.image_yscale
		
		self.TargetX = scr_lerp(self.TargetX,obj_player1.x,14)
		self.TargetY = scr_lerp(self.TargetY,obj_player1.y,14)
		
		a.Instance.x = scr_lerp(a.Instance.x,self.TargetX,12)
		a.Instance.y = scr_lerp(a.Instance.y,self.TargetY,12)
		self.FallVelocity += delta()*(520)
		a.Instance.image_speed += delta()*0.2
	}
	
	if struct_exists(a.Instance,"Hurtbox") {
		if a.Height > 20 {
			a.Instance.Hurtbox.Enabled = false
		} else {
			a.Instance.Hurtbox.Enabled = true
		}
	}
	
	if a.Height == 0 {
		
		self.FallVelocity = -300
		
		if self.CurrentType == "bouncing" && self.BouncesCount > 0 {
			a.Instance.image_yscale = 0.82
		} else if self.BouncesCount == 0 {
			self.FallVelocity = -100
		}
		
		if !self.BouncesCount == 1 {
			repeat (24) {
				var ins =  instance_create_depth(a.Instance.x,a.Instance.y,a.Instance.depth,obj_blankbulletasset)
				ins.BulletAsset.Height = 0
				ins.BulletAsset.HeightVelocity = -1*irandom_range(-100,-200)
				ins.BulletAsset.PreformHeightGravity = true
				ins.BulletAsset.Speed = irandom_range(30,50)*1.5
				ins.BulletAsset.SpeedAdjustment = -70
				ins.BulletAsset.SpeedMinimum = 0
				ins.BulletAsset.Angle = irandom_range(0,360)
				ins.sprite_index = spr_eyeboss_rocks
				ins.image_speed = 0
				ins.image_index = irandom_range(1,ins.image_number)
				ins.image_angle = irandom_range(0,360)
				ins.BulletAsset.Lifetime = random_range(3,4)
			}
			
			var angle = 0
			
			repeat (8) {
		
				angle += 45
				var hbTest = instance_create_depth(a.Instance.x,a.Instance.y,a.Instance.depth,obj_eyeboss_bigeyebullets)
				hbTest.BulletAsset.OrbitalAngle = angle
				hbTest.Hurtbox.Team = a.Team
				hbTest.BulletAsset.OrbitalDistance = 0
				
				
				repeat(7) {
					scr_boss_eye_particles(
					hbTest.x+lengthdir_x(hbTest.BulletAsset.OrbitalDistance,hbTest.BulletAsset.OrbitalAngle),
					hbTest.y+lengthdir_y(hbTest.BulletAsset.OrbitalDistance,hbTest.BulletAsset.OrbitalAngle))
			}
			
		}
		}
		
		self.BouncesCount -= 1
		
		if self.BouncesCount < 0 {
			a.Instance.image_speed = 1
			a.Instance.image_xscale = 1
			a.Instance.image_yscale = 1
			a.StateEnded = true
			a.Height = -5
			return
			
		} 
		
		if self.CurrentType != "bouncing" {
			set_sprite_type_direction("Smash",a)
			a.Instance.image_speed = 0.8
		}
		
		self.CurrentType = "bouncing"
		self.TargetX = obj_player1.x
		self.TargetY = obj_player1.y
		
		
	}
}

//PREFORMS A WAIT WHILE CHASING PLAYER BEFORE CHANGING STATE
global.States.Boss_TimerChase = new global.State()
global.States.Boss_TimerChase.AllowMovement = true
global.States.Boss_TimerChase.MovementBehavior = "chasePlayer"
global.States.Boss_TimerChase.NextState = noone
global.States.Boss_TimerChase.Start = function(a,nextState,timer = 3) {
	self.NextState = nextState
	self.Timer = timer
}

global.States.Boss_TimerChase.Frame = function(a) {
	self.Timer -= delta()
	
	if self.Timer < 0 {
		if self.NextState {
			a.CurrentState = self.NextState
			self.NextState.Start(a)
		} else {
			a.StateEnded = true
		}
	}
}

//RELEASES BULLETS FROM EYES FOR A SET NUMBER OF SECONDS
global.States.Boss_EyeBulletStream = new global.State()
global.States.Boss_EyeBulletStream.AllowMovement = true
global.States.Boss_EyeBulletStream.MovementBehavior = "chasePlayer"
global.States.Boss_EyeBulletStream.NextState = noone
global.States.Boss_EyeBulletStream.TemporaryTimer = 0
global.States.Boss_EyeBulletStream.Start = function(a,timer = 3) {
	self.Timer = timer
	self.TemporaryTimer = 0
}

global.States.Boss_EyeBulletStream.Frame = function(a) {
	self.Timer -= delta()
	self.TemporaryTimer += delta()
	
	if self.TemporaryTimer > 0.4 {
		
		self.TemporaryTimer = 0
		
		var realAngle = 360-a.WalkingAngle
		realAngle += 22.5
		realAngle = realAngle % 360
		
		realAngle = floor(realAngle/45)
		realAngle *= 45
		
		realAngle = point_direction(a.Instance.x,a.Instance.y,obj_player1.x,obj_player1.y) + irandom_range(-40,40)
		var dist = irandom_range(50,70)
		
		var xAdd = lengthdir_x(dist,realAngle)
		var yAdd = lengthdir_y(dist,realAngle)
		
			
		if struct_exists(a.Instance,"Hitbox") {
			a.Instance.Hitbox.KnockbackX -= lengthdir_x(50,realAngle)
			a.Instance.Hitbox.KnockbackY += lengthdir_y(50,realAngle)
		}
		a.WalkingSpeedCurrent = 0
		
		var angle = irandom_range(0,360)
		var angleAdjustment = irandom_range(-25,25)
		
		
		var otherAngle = point_direction(a.Instance.x,a.Instance.y,obj_player1.x,obj_player1.y) + irandom_range(-30,30)
		repeat (8) {
	
		
		
			angle += 45
			var hbTest = instance_create_depth(a.Instance.x + xAdd,a.Instance.y + yAdd,a.Instance.depth,obj_eyeboss_spiralbullets)
			hbTest.BulletAsset.OrbitalAngle = angle
			hbTest.BulletAsset.AngleAdjustment = angleAdjustment
			
			hbTest.Hurtbox.Team = a.Team
			hbTest.BulletAsset.Angle = otherAngle
			
		}
		
		repeat (15) {
			scr_boss_eye_particles(a.Instance.x + xAdd,a.Instance.y + yAdd)
		}
	}
	
	
	if self.Timer < 0 {	
			a.StateEnded = true
	}
}

global.States.Boss_Eye_RepeatingWaves = new global.State()
global.States.Boss_Eye_RepeatingWaves.AllowMovement = false
global.States.Boss_Eye_RepeatingWaves.Start = function(a,force = 1000) {
	self.Timer = 0
	self.TimesPreform = irandom_range(2,4)
	
	set_sprite_type_direction("Spin",a)
}

global.States.Boss_Eye_RepeatingWaves.Frame = function(a) {
	self.Timer += delta()
	
	
	
	if self.Timer > 0.5 {
		self.Timer = 0
		self.TimesPreform -= 1
		
		if self.TimesPreform == 0 {
			a.StateEnded = true
		}
		
		var angle = self.TimesPreform*45
		
		
		repeat (6) {
		
			angle += 60
			var hbTest = instance_create_depth(a.Instance.x,a.Instance.y,a.Instance.depth,obj_eyeboss_bigeyebullets)
			hbTest.BulletAsset.OrbitalAngle = angle
			hbTest.Hurtbox.Team = a.Team
			
			hbTest.BulletAsset.OrbitalAngleVelocity = 0
			hbTest.BulletAsset.OrbitalAngleVelocityAdjustment = 70
			hbTest.BulletAsset.OrbitalAngleVelocityMaximum = 70
			hbTest.BulletAsset.Lifetime = irandom_range(8,8.5)
			
			
			hbTest.BulletAsset.OrbitalDistanceAdjustmentVelocity = 60
			hbTest.BulletAsset.OrbitalDistanceAdjustmentVelocityVelocity = 700
			hbTest.BulletAsset.OrbitalDistanceAdjustmentVelocityMaximum = 240
			
			repeat(4) {
				scr_boss_eye_particles(
				hbTest.x+lengthdir_x(hbTest.BulletAsset.OrbitalDistance,hbTest.BulletAsset.OrbitalAngle),
				hbTest.y+lengthdir_y(hbTest.BulletAsset.OrbitalDistance,hbTest.BulletAsset.OrbitalAngle))
			}
			
		}
	}
}