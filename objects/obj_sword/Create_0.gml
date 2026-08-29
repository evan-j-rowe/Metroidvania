attacking = false
attack_timer = 0
sweeping_distance_current = 0
sweeping_multiplier = 1
current_weapon = "sword"
debounce = 0

angle = 0

swordData = {
	damage: 8,
	sweeping_distance: 160,
	sweeping_timer: 0.4,
	sweeping_lerp_value : 32,
	debounce: 0.25,
	damage_width : 60,
	damage_height : 50,
	distance : 15,
}

Hurtbox = new global.Hurtbox(self,"Player")
Hurtbox.Knockback = 200
Hurtbox.Enabled = false