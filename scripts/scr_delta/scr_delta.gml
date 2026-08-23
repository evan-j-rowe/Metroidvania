function delta() {
	return delta_time/1000000
}

function delta_ui() {
	return delta_time/1000000
}

function scr_lerp(s,e,d){
	var blend = 1 - power(0.777,delta() * d)
	return lerp(s,e,blend)
}

global.hurtboxPlayerDelay = 1

function set_depth(rank) {
	return -rank
}

function set_depth_instance(ins) {
	ins.depth = -ins.bbox_bottom/10
}