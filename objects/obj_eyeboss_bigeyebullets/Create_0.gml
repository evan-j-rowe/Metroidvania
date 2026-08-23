Hurtbox = new global.Hurtbox(self,"Enemies")
Hurtbox.TimesDealDamage = 1
Hurtbox.Knockback = global.BULLET_DEFAULT_KNOCKBACK

BulletAsset = new global.BulletAsset(self)


			
BulletAsset.OrbitalAngleVelocity = 0
BulletAsset.OrbitalAngleVelocityAdjustment = 70
BulletAsset.OrbitalAngleVelocityMaximum = 50
BulletAsset.Lifetime = irandom_range(8,8.5)
BulletAsset.OrbitalDistance = 40
			
			
BulletAsset.OrbitalDistanceMaximum = infinity
BulletAsset.OrbitalDistanceAdjustment = 0
BulletAsset.OrbitalDistanceAdjustmentVelocity = 60
BulletAsset.OrbitalDistanceAdjustmentVelocityVelocity = 700
BulletAsset.OrbitalDistanceAdjustmentVelocityMaximum = 130
			