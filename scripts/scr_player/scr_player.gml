//player
global.PlayerTemplate = function() constructor {
  Name = "Nameless"
  InputMode = "Keyboard/Mouse" //ControllerId
  Humanoid = noone
}

global.money = 0

global.Player = []
global.Is2Player = false

global.Player[0] = new global.PlayerTemplate()
global.Player[0].GunValue = 0
global.Player[0].ManaValue = 0

global.Player[1] = noone


global.Paused = false

