//player
global.PlayerTemplate = function() constructor {
  Name = "Nameless"
  InputMode = "Keyboard/Mouse" //ControllerId
  Humanoid = noone
 
  //energy/charge/weapons
  ManaValue = 0.3 //goes up to 1
  PrimaryWeapon = ""
  Guns = []
  GunValue = 0
  Currency = 4
  Upgrades = []
}

global.money = 0

global.Player = []
global.Is2Player = false

global.Player[0] = new global.PlayerTemplate()
global.Player[0].GunValue = 0
global.Player[0].ManaValue = 0

global.Player[1] = noone


global.Paused = false

