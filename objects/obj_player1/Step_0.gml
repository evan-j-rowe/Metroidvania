Hitbox.HitboxFrame()
Behavior.Frame()

show_debug_message(depth)

if Hitbox.DamageCooldown > 0 {
	image_alpha = round((current_time%300)/300)
} else {
	image_alpha = 1
}