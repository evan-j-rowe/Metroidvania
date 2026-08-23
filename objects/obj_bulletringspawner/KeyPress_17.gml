
	var angle = irandom_range(0,360)
	var angleAdjustment = irandom_range(-10,10)
	repeat (8) {
	
		
		
		angle += 45
		var hbTest = instance_create_depth(x,y,depth,obj_hurtboxtest)
		hbTest.BulletAsset.OrbitalAngle = angle
		hbTest.BulletAsset.AngleAdjustment = angleAdjustment
	}