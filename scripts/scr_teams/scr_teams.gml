global.Teams = {}

function createTeam(name) {
	struct_set(global.Teams,name,{Hitboxes : [], Hurtboxes : [],Entities : []})
}

createTeam("Player") 
createTeam("Enemies")
createTeam("NeutralHitboxes")
createTeam("NeutralHurtboxes")
createTeam("PlayerOnlyHurtboxes") //Enemies that deal damage on touch

function getAllGroupsHurtboxes(exception = noone,player = false) {
	global.exceptionABgAGH = exception
	global.playerABgAGH = player
	global.endHurtboxesABgAGH = []
	
	funct = function(teamName,teamBoxes) { //Check all teams to see if they arent the calling team and compile their hurtboxes
		if teamName == "PlayerOnlyHurtboxes" && !self.Player && !global.playerABgAGH || teamName == global.exceptionABgAGH {
			
		} else {

			array_foreach(teamBoxes.Hurtboxes,function(value,index) {
				if value.Enabled && value.DamageCooldownExpire <= current_time && value.Instance {
					array_push(global.endHurtboxesABgAGH,value.Instance)
				}
			})
		}
	}
	
	struct_foreach(global.Teams,funct )
	
	return global.endHurtboxesABgAGH
}

global.Hitbox = function(instance,team = "NeutralHitboxes",entity = noone,hitpoints = 24) constructor {
	Entity = entity
	Team = team
	Instance = instance
	
	Player = false
	
	Health = hitpoints
	MaxHealth = hitpoints
	MaxIsMaximum = true
	CanDie = true
	CanHeal = true
	
	CanTakeDamage = true
	IgnoreHitboxes = false	
	
	TookDamageThisFrame = 0
	LastDamageCount = -1
	CurrentFrame = 0
	DamageCooldown = -1
	
	CanTakeKnockback = true
	KnockbackMultiplier = 1
	CanBounceOffWalls = 0
	
	KnockbackX = 0
	KnockbackY = 0
	KnockbackFriction = 12
	
	CheckForDamage = function() {
		var hitboxes = getAllGroupsHurtboxes(self.Team)
		
		global.detectedABgAGH = noone
		
		with self.Instance {
			global.detectedABgAGH = instance_place(x,y,hitboxes)
		}
		
		if global.detectedABgAGH {
			self.Damage()
		}
	}
	
	Damage = function() {
		var a = global.detectedABgAGH.Hurtbox
			
		if self.CanTakeDamage {
			var dmg = a.Damage 
			if self.Player {
				dmg = 1
			}
			
			self.Health -=
			dmg
				
			if self.CanDie && self.Health <= 0 {
				self.Death()
				self.DeathAdd()
			}
		}
		
		if self.CanTakeKnockback && a.Knockback != 0  {
			if !self.Player || !struct_get(a.Instance,"BulletAsset") {
			
				var directionKnockback = point_direction(a.Instance.x,a.Instance.y,self.Instance.x,self.Instance.y)
			
				if struct_exists(a.Instance,"BulletAsset") {
					directionKnockback = a.Instance.BulletAsset.Angle
				}
			
			
				self.KnockbackX = lengthdir_x(a.Knockback*self.KnockbackMultiplier,directionKnockback)
				self.KnockbackY = lengthdir_y(a.Knockback*self.KnockbackMultiplier,directionKnockback)
			}
		}
		
		if self.Health > 0 || self.CanDie {
			self.DamageAdd()
		}
			
		a.TimesDealDamage -= 1
				
		if a.TimesDealDamage == 0 {
			a.DestroyFunction()
			a.DestroyParticles()
		} else {
			a.DamageFunction()
			a.DamageParticles()
		}
			
		a.DamageCooldownExpire = current_time + a.DamageCooldown
	}
	
	HitboxFrame = function() {
		self.TookDamageThisFrame = 0
		self.DamageCooldown -= delta()
		
		if self.DamageCooldown < 0 && !self.IgnoreHitboxes && self.Instance {
			CheckForDamage()
		}
		
		if self.KnockbackMultiplier != 0 {
			self.Instance.x += self.KnockbackX*delta()
			self.Instance.y += self.KnockbackY*delta()
			
			self.KnockbackX = scr_lerp(self.KnockbackX,0,self.KnockbackFriction)
			self.KnockbackY = scr_lerp(self.KnockbackY,0,self.KnockbackFriction)
		}
	}
	
	DamageAdd = function() {
		
	}
	
	Death = function() {
		instance_destroy(self.Instance)
	}
	
	DeathAdd = function() {
		
	}
	
	SetTeam = function(team="NeutralHitboxes") {
		self.Team = team
		array_push(struct_get(global.Teams,team).Hitboxes,self)
	}
	
	self.SetTeam(team)
}

global.Hurtbox = function(instance,team = noone,enabled = true,damage = 10) constructor {
	Instance = instance
	Enabled = enabled
	Team = team
	
	Damage = damage
	TimesDealDamage = -1
	DamageCooldown = 500 //milliseconds
	DamageCooldownExpire = current_time
	
	Knockback = 0
	
	
	DestroyFunction = function() {
		instance_destroy(self.Instance)
	}
	
	DestroyParticles = function() {
	
	}
	
	DamageFunction = function() {
	
	}
	
	DamageParticles = function() {
	
	}
	
	SetTeam = function(team="NeutralHurtboxes") {
		self.Team = team
		array_push(struct_get(global.Teams,team).Hurtboxes,self)
	}
	
	if team != noone {
		self.SetTeam(team)
	}
}

