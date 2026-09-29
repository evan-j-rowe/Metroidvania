Hurtbox = new global.Hurtbox(self,"Enemies")
Hurtbox.TimesDealDamage = 1
Hurtbox.Knockback = global.BULLET_DEFAULT_KNOCKBACK

BulletAsset = new global.BulletAsset(self)
BulletAsset.Speed = 300
BulletAsset.SpeedAdjustment = -400
BulletAsset.SpeedMinimum = 0
BulletAsset.Height = 20
BulletAsset.HeightVelocity = 100
BulletAsset.PreformHeightGravity = true
BulletAsset.RenderShadow = true