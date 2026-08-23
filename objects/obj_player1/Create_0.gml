Hitbox = new global.Hitbox(self,"Player")

Hitbox.Player = true
Hitbox.Health = 5
Hitbox.DamageAdd = function() {
	Hitbox.DamageCooldown = 0.9
}

Behavior = new global.Behavior(self,"Player")
Behavior.States[0] = variable_clone(global.States.Player1)
Behavior.CurrentState = Behavior.States[0]
Behavior.CurrentState.Start(Behavior)
Behavior.WalkingSpeed *= 2.3
