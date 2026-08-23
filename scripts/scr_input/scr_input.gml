
function get_player_held(player,input) {
	var keycode = struct_get(global.Settings.Controls[player].keyboard,input)
	if keycode[1] == "keyboard" {
		return keyboard_check(keycode[0])
	} else if keycode[1] == "mouse" {
		return mouse_check_button(keycode[0])
	}
}

function get_player_released(player,input) {
	var keycode = struct_get(global.Settings.Controls[player].keyboard,input)
	if keycode[1] == "keyboard" {
		return keyboard_check_released(keycode[0])
	} else if keycode[1] == "mouse" {
		return mouse_check_button_released(keycode[0])
	}
}

function keycode_to_string(keycode) {
	switch (keycode) {
		case ord("Q"): //letters
			return "Q"
		case ord("W"):
			return "W"
		case ord("E"):
			return "E"
		case ord("R"):
			return "R"
		case ord("T"):
			return "T"
		case ord("Y"):
			return "Y"
		case ord("U"):
			return "U"
		case ord("I"):
			return "I"
		case ord("O"):
			return "O"
		case ord("P"):
			return "P"
		case ord("A"):
			return "A"
		case ord("S"):
			return "S"
		case ord("D"):
			return "D"
		case ord("F"):
			return "F"
		case ord("G"):
			return "G"
		case ord("H"):
			return "H"
		case ord("J"):
			return "J"
		case ord("K"):
			return "K"
		case ord("L"):
			return "L"
		case ord("Z"):
			return "Z"
		case ord("X"):
			return "X"
		case ord("C"):
			return "C"
		case ord("V"):
			return "V"
		case ord("B"):
			return "B"
		case ord("N"):
			return "N"
		case ord("M"):
			return "M"
		case ord("0"):
			return "M"
		case ord("1"):
			return "1"
		case ord("2"):
			return "2"
		case ord("3"):
			return "3"
		case ord("4"):
			return "4"
		case ord("5"):
			return "5"
		case ord("6"):
			return "6"
		case ord("7"):
			return "7"
		case ord("8"):
			return "8"
		case ord("9"):
			return "9"
		case vk_left:
			return "LEFT"
		case vk_right:
			return "RIGHT"
		case vk_up:
			return "UP"
		case vk_down:
			return "DOWN"
		case vk_enter:
			return "ENTER"
		case vk_escape:
			return "ESCAPE"
		case vk_space:
			return "SPACE"
		case vk_shift:
			return "SHIFT"
		case vk_control:
			return "CTRL"
		case vk_alt:
			return "ALT"
		case vk_backspace:
			return "BACKSPACE"
		case vk_tab:
			return "TAB"
		case vk_home:
			return "HOME"
		case vk_end:
			return "END"
		case vk_delete:
			return "DELETE"
		case vk_insert:
			return "INSERT"
		case vk_pageup:
			return "PAGE UP"
		case vk_pagedown:
			return "PAGE DOWN"
		case vk_pause:
			return "PAUSE"
		case vk_printscreen:
			return "PRINTSCREEN"
		case vk_f1:
			return "F1"
		case vk_f2:
			return "F2"
		case vk_f3:
			return "F3"
		case vk_f4:
			return "F4"
		case vk_f5:
			return "F5"
		case vk_f6:
			return "F6"
		case vk_f7:
			return "F7"
		case vk_f8:
			return "F8"
		case vk_f9:
			return "F9"
		case vk_f10:
			return "F10"
		case vk_f11:
			return "F11"
		case vk_f12:
			return "F12"
		case vk_numpad0:
			return "NUMPAD 0"
		case vk_numpad1:
			return "NUMPAD 1"
		case vk_numpad2:
			return "NUMPAD 2"
		case vk_numpad3:
			return "NUMPAD 3"
		case vk_numpad4:
			return "NUMPAD 4"
		case vk_numpad5:
			return "NUMPAD 5"
		case vk_numpad6:
			return "NUMPAD 6"
		case vk_numpad7:
			return "NUMPAD 7"
		case vk_numpad8:
			return "NUMPAD 8"
		case vk_numpad9:
			return "NUMPAD 9"
		case vk_multiply:
			return "MULTIPLY"
		case vk_divide:
			return "DIVIDE"
		case vk_add:
			return "ADD"
		case vk_subtract:
			return "SUBTRACT"
		case vk_decimal:
			return "DECIMAL"
		case vk_lshift:
			return "L SHIFT"
		case vk_lcontrol:
			return "CTRL"
		case vk_lalt:
			return "ALT"
		case vk_rshift:
			return "R SHIFT"
		case vk_rcontrol:
			return "R CTRL"
		case vk_ralt:
			return "R ALT"
		case mb_left:
			return "LEFT CLICK"
		case mb_middle:
			return "MIDDLE CLICK"
		case mb_right:
			return "RIGHT CLICK"
		case mb_side1:
			return "SIDE CLICK 1"
		case mb_side2:
			return "SIDE CLICK 2"
	}	
}
