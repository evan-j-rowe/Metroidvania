Hitbox = new global.Hitbox(self,"Enemies")
Hitbox.Health = 35//0

Behavior = new global.Behavior(self,"Enemies")
Behavior.States[0] = variable_clone(global.States.Boss_TimerChase)

Behavior.States[1] = new global.States.General_Smash()
Behavior.States[1].JumpForceY = 450
Behavior.States[1].JumpDrag *= 2
Behavior.States[1].LandTimer = 0
Behavior.States[1].JumpStretch = true
Behavior.States[1].JumpStretchValue = 3000
Behavior.States[1].PrepareTimer = 0


Behavior.States[1].PrepareFrameFunction =  function() {
	Behavior.States[1].PrepareX = obj_player1.x
	Behavior.States[1].PrepareY = obj_player1.y
}

Behavior.States[1].LandFunction = function() {
	repeat (24) {
		var ins =  instance_create_depth(x,y,depth,obj_blankbulletasset)
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
		var hbTest = instance_create_depth(x,y,depth,obj_eyeboss_bigeyebullets)
		hbTest.BulletAsset.OrbitalAngle = angle
		hbTest.Hurtbox.Team = Behavior.Team
		hbTest.BulletAsset.OrbitalDistance = 30
		hbTest.BulletAsset.OrbitalDistanceAdjustment += 100
				
				
		repeat(7) {
			scr_boss_eye_particles(
			hbTest.x+lengthdir_x(hbTest.BulletAsset.OrbitalDistance,hbTest.BulletAsset.OrbitalAngle),
			hbTest.y+lengthdir_y(hbTest.BulletAsset.OrbitalDistance,hbTest.BulletAsset.OrbitalAngle))
		}
	}
}

Behavior.States[2] = variable_clone(global.States.Boss_EyeBulletStream)

Behavior.States[3] = new global.States.General_Dash()
Behavior.States[3].DashForce = 1200

Behavior.States[4] = variable_clone(global.States.Boss_Eye_RepeatingWaves)

Behavior.Sprites.Movement = new global.SpriteData()
Behavior.Sprites.Movement.Type = SpriteTypes.Left_LeftUp_Up_RightUp_Right_RightDown_Down_LeftDown
Behavior.Sprites.Movement.Sprites = [
	[spr_eyebossidle_side,1],
	[spr_eyebossidle_back,1],
	[spr_eyebossidle_back,1],
	[spr_eyebossidle_back,1],
	[spr_eyebossidle_side,-1],
	[spr_eyebossidle_forwardside,-1],
	[spr_eyebossidle_forward,1],
	[spr_eyebossidle_forwardside,1],
]

Behavior.Sprites.Smash_Jump = create_single_sprite(spr_eyeboss_spinning)
Behavior.Sprites.Smash_Land = Behavior.Sprites.Movement
Behavior.Sprites.Spin = Behavior.Sprites.Smash_Jump

Behavior.PickState = function() {
	Behavior.CurrentState = Behavior.States[0]

	
	Behavior.CurrentState.Start(Behavior,Behavior.States[irandom_range(1,4)],2.7)
	Behavior.StateEnded = false
}

Behavior.WalkingSpeed *= 1.2


Hurtbox = new global.Hurtbox(self,"PlayerOnlyHurtboxes")
Hurtbox.Knockback = global.TOUCH_DEFAULT_KNOCKBACK

DashLerp = 100