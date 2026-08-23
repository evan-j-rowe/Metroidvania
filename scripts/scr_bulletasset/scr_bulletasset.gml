global.BulletAsset = function(instance) constructor {
	Instance = instance
	
	RotationSpeed = 0
	
	Angle = 0
	AngleAdjustment = 0
	Speed = 0
	SpeedAdjustment = 0
	SpeedMaximum = infinity
	SpeedMinimum = -infinity
	
	
	PhaseX = instance.x
	PhaseY = instance.y
	
	Height = 10
	RenderShadow = false
	PreformHeightGravity = false
	HeightVelocity = 0
	
	
	OrbitalAngle = 0
	
	OrbitalAngleVelocity = 0
	OrbitalAngleVelocityAdjustment = 0
	OrbitalAngleVelocityMaximum = infinity
	OrbitalAngleVelocityMinimum = -infinity
	
	OrbitalDistance = 0
	OrbitalDistanceAdjustment = 0
	OrbitalDistanceMaximum = infinity
	OrbitalDistanceMinimum = 0
	
	OrbitalDistanceAdjustmentVelocity = 0
	OrbitalDistanceAdjustmentVelocityMaximum = infinity
	OrbitalDistanceAdjustmentVelocityVelocity = 0
	
	Lifetime = infinity
	
	Draw = function() {
		set_depth_instance(self.Instance)
		
		if !self.Instance {
			return
		}
		
		if self.PreformHeightGravity {
			self.HeightVelocity -= delta()*600
			
			self.Height = max(self.Height + self.HeightVelocity*delta(),0)
		}
		
		self.Lifetime -= delta()
		if self.Lifetime < 0 {
			instance_destroy(self.Instance)
			return
		}
		
		//Adjust Angle and Speed
		self.Angle += self.AngleAdjustment*delta()
		self.Speed += self.SpeedAdjustment*delta()
		self.Speed = clamp(self.Speed,self.SpeedMinimum,self.SpeedMaximum)
		
		self.OrbitalAngle += self.OrbitalAngleVelocity*delta()
		self.OrbitalAngleVelocity += self.OrbitalAngleVelocityAdjustment*delta()
		self.OrbitalAngleVelocity = clamp(self.OrbitalAngleVelocity,self.OrbitalAngleVelocityMinimum,self.OrbitalAngleVelocityMaximum)
		
		self.OrbitalDistanceAdjustmentVelocity = min(self.OrbitalDistanceAdjustmentVelocity + OrbitalDistanceAdjustmentVelocityVelocity*delta())
		self.OrbitalDistanceAdjustment = min(self.OrbitalDistanceAdjustment + self.OrbitalDistanceAdjustmentVelocity*delta(),self.OrbitalDistanceAdjustmentVelocityMaximum)
		
		self.OrbitalDistance += self.OrbitalDistanceAdjustment*delta()
		self.OrbitalDistance = clamp(self.OrbitalDistance,self.OrbitalDistanceMinimum,self.OrbitalDistanceMaximum)
		
		self.PhaseX += lengthdir_x(self.Speed*delta(),self.Angle)
		self.PhaseY += lengthdir_y(self.Speed*delta(),self.Angle)
		
		self.Instance.x = self.PhaseX + lengthdir_x(self.OrbitalDistance,self.OrbitalAngle)
		self.Instance.y = self.PhaseY + lengthdir_y(self.OrbitalDistance,self.OrbitalAngle)
		
		self.Instance.image_angle += self.RotationSpeed*delta()
	
		var ins = self.Instance
		if self.RenderShadow {
			draw_sprite_ext(ins.sprite_index,
			ins.image_index,
			ins.x,ins.y,
			ins.image_xscale,
			ins.image_yscale,
			ins.image_angle,
			c_black,
			ins.image_alpha*0.25) //shadow
		}
		
					
		draw_sprite_ext(ins.sprite_index,
		ins.image_index,
		ins.x,ins.y - self.Height,
		ins.image_xscale,
		ins.image_yscale,
		ins.image_angle,
		ins.image_blend,
		ins.image_alpha) //normal
	}	
	
	
}