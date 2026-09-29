Hitbox = new global.Hitbox(self,"Enemies")
Hitbox.Health = 18

Behavior = new global.Behavior(self,"Enemies")
Behavior.States[0] = new global.States.General_WanderUntilDistance()
Behavior.States[1] = new global.States.General_BulletExplusion()
Behavior.States[1].BulletType = obj_flyingspitter_goop
Behavior.States[1].DelayBeforeSpit = 3
Behavior.States[2] = variable_clone(global.States.Boss_TimerChase)
Behavior.States[0].DistanceUntilChase = 160
Behavior.States[0].WanderBoundry = 30
Behavior.WalkingSpeed = 10

Behavior.PickState = function() {
	Behavior.CurrentState = Behavior.States[0]

	
	Behavior.CurrentState.Start(Behavior,Behavior.States[1])
	Behavior.StateEnded = false
}

Hurtbox = new global.Hurtbox(self,"PlayerOnlyHurtboxes")
Hurtbox.Knockback = global.TOUCH_DEFAULT_KNOCKBACK