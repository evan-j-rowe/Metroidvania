Hitbox.HitboxFrame()
Behavior.Frame()

if Behavior.CurrentState == Behavior.States[3] {
	if Behavior.CurrentState.Timer < Behavior.CurrentState.DelayBeforeDash {
		DashLerp = scr_lerp(DashLerp,0,0.15)
		var angle = point_direction(x,y,obj_player1.x,obj_player1.y)+180
		
		x += lengthdir_x(DashLerp*delta(),angle)
		y += lengthdir_y(DashLerp*delta(),angle)
	}
} else {
	DashLerp = 100
}

if Behavior.CurrentState != Behavior.States[1] {
	self.Behavior.Height = scr_lerp(self.Behavior.Height,2+sin(current_time/300)*3,25)
}