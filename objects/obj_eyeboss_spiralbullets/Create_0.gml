Hurtbox = new global.Hurtbox(self,"Enemies")
Hurtbox.TimesDealDamage = 1
Hurtbox.Knockback = global.BULLET_DEFAULT_KNOCKBACK

BulletAsset = new global.BulletAsset(self)


BulletAsset.Speed = -50
BulletAsset.SpeedMaximum = 250
BulletAsset.SpeedAdjustment = 250
BulletAsset.OrbitalAngleVelocity = 0
BulletAsset.OrbitalAngleVelocityAdjustment = 500
BulletAsset.OrbitalAngleVelocityMaximum = 960
BulletAsset.Lifetime = 10
			
BulletAsset.OrbitalDistanceMaximum = 10
BulletAsset.OrbitalDistanceAdjustment = 25