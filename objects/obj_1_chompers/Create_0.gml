Hitbox = new global.Hitbox(self,"Enemies")
Hitbox.Health = 35//0

Behavior = new global.Behavior(self,"Enemies")
Behavior.States[0] = new global.States.General_WanderUntilDistance()
Behavior.States[1] = new global.States.General_Dash()
Behavior.States[1].DelayBeforeDash = 1.5
Behavior.States[0].DistanceUntilChase = 160
Behavior.WalkingSpeed = 10

Behavior.PickState = function() {
	Behavior.CurrentState = Behavior.States[0]

	
	Behavior.CurrentState.Start(Behavior,Behavior.States[1])
	Behavior.StateEnded = false
}

Hurtbox = new global.Hurtbox(self,"PlayerOnlyHurtboxes")
Hurtbox.Knockback = global.TOUCH_DEFAULT_KNOCKBACK