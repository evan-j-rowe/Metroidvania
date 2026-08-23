enum SpriteTypes  {
	Single,
	Left_Right,
	LeftUp_LeftDown_RightUp_RightDown,
	Left_Right_Up_Down,
	Left_LeftUp_Up_RightUp_Right_RightDown_Down_LeftDown
}

global.SpriteData = function() constructor {
	Type = SpriteTypes.Left_Right
	Sprites = []
}

function set_sprite_type_direction(SpriteName,a) {
	if !struct_exists(a.Sprites,SpriteName) {
		return
	}
	
	var Data = struct_get(a.Sprites,SpriteName)
	var chosenDataIndex = -1
	
	if Data.Type == SpriteTypes.Left_LeftUp_Up_RightUp_Right_RightDown_Down_LeftDown {
		var realAngle = 360-a.WalkingAngle
		realAngle += 22.5 + 180
		realAngle = realAngle % 360
		
		index = floor(realAngle/45)
		
		chosenDataIndex = index
		show_debug_message(index)
	} else if Data.Type == SpriteTypes.Single {
		chosenDataIndex = 0
	}
	
	if chosenDataIndex != -1  {
		if a.Instance.sprite_index != Data.Sprites[chosenDataIndex][0] {
			a.Instance.sprite_index = Data.Sprites[chosenDataIndex][0]
		}
		
		a.Instance.image_xscale *= sign(a.Instance.image_xscale)* Data.Sprites[chosenDataIndex][1]
	}

}

function create_single_sprite(sprite,width = 1) {
	var n = new global.SpriteData()
	n.Type = SpriteTypes.Single
	n.Sprites[0] = [sprite,width]
	
	return n
}