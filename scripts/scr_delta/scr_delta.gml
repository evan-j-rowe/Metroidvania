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

global.PITDEPTH = 2000
global.FLOORDEPTH = 0
global.WALLSDEPTH = -2000
global.ROOFDEPTH = -4000
global.UIDEPTH = -4500


function set_depth(rank) {
	return -rank + -2500
}

function set_depth_instance(ins) {
	ins.depth = -ins.bbox_bottom/10
}