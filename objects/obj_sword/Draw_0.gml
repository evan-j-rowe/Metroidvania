draw_self()

var currentsword = swordData
debounce -= delta()

if mouse_check_button_pressed(mb_left) && attacking == false && debounce <= 0 {
	Hurtbox.Enabled = true
	attacking = true
	attack_timer = currentsword.sweeping_timer
	sweeping_multiplier = (irandom_range(0,1)*2) - 1
	sweeping_distance_current = 0
	
	angle = point_direction(obj_player1.x,obj_player1.y,mouse_x,mouse_y)
	
	image_xscale = currentsword.damage_width
	image_yscale = currentsword.damage_height
	Hurtbox.Damage = currentsword.damage
}

if attacking {
	attack_timer -= delta()
	
	sweeping_distance_current = scr_lerp(sweeping_distance_current,
	currentsword.sweeping_distance,
	currentsword.sweeping_lerp_value)
	
	var swordAngleCurrent = (angle - currentsword.sweeping_distance*sweeping_multiplier/2) + sweeping_distance_current*sweeping_multiplier
	
	x = obj_player1.x + lengthdir_x(currentsword.distance,angle)
	y = obj_player1.y + lengthdir_y(currentsword.distance,angle)
	image_angle = angle
	
	draw_sprite_ext(
		spr_basesword,
		image_index,
		obj_player1.x + lengthdir_x(currentsword.distance,swordAngleCurrent),
		obj_player1.y + lengthdir_y(currentsword.distance,swordAngleCurrent),
		1,
		1,
		swordAngleCurrent,
		c_white,
		1
	)
	
	if attack_timer < 0 {
		attacking = false
		Hurtbox.Enabled = false
		debounce = currentsword.debounce
	}
}