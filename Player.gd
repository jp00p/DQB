extends Node

class_name Player

signal player_hp_changed
signal player_mp_changed
signal player_gold_changed
signal player_xp_changed
signal player_level_changed
signal player_died

export var NAME = "jp00p"
export var level = 1 setget set_player_level
export var strength = 0
export var agility = 0
export var max_hp = 55
export var max_mp = 25
export var dodge = 0
export var xp = 0 setget set_player_xp
export var gold = 0 setget set_player_gold

var weapon = Globals.WEAPONS.club
var armor = Globals.ARMORS.clothes

var known_spells = ["heal"]


var hp = max_hp setget set_player_hp
var mp = max_mp setget set_player_mp

func set_player_hp(val):
	hp = clamp(val, 0, max_hp)
	print("My hp changed")
	emit_signal("player_hp_changed", hp)
	if hp <= 0:
		emit_signal("player_died")

func set_player_mp(val):
	mp = clamp(val, 0, max_mp)
	print("My mp changed")
	emit_signal("player_mp_changed", mp)

func set_player_xp(val):
	xp = clamp(val, 0, 9999)
	emit_signal("player_xp_changed", xp)
	
func set_player_gold(val):
	gold = clamp(val, 0, 65356)
	emit_signal("player_gold_changed", gold)

func set_player_level(val):
	level = clamp(0, val, 30)
	emit_signal("player_level_changed", level)
