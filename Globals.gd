extends Node


var ENEMIES = {
	"Slime" : load("res://Enemies/Slime.tscn"),
	"RedSlime" : load("res://Enemies/RedSlime.tscn")
}


var WEAPONS = {
	"bamboo_pole": {
		"name" : "Bamboo Pole",
		"offense" : 2,
		"cost" : 10
	},
	"club" : {
		"name" : "Club",
		"offense" : 4,
		"cost" : 60
	}
}

var ARMORS = {
	"clothes"  : {
		"name" : "Clothes",
		"defense" : 2,
		"cost" : 20
	},
	"leather_armor" : {
		"name" : "Leather Armor",
		"defense" : 4,
		"cost" : 70
	}
}

var SPELLS = {
	"heal" : {
		"name" : "Heal",
		"cost" : 3,
		"effect" : ["heal_self", 15]  
	},
	"hurt" : {
		"name" : "Hurt",
		"cost" : 5,
		"effect" : ["hurt_target", 15]
	}
}

# spell functions

func heal_self(amt, target):
	target.hp += int(rand_range(amt, amt*2))
	
func hurt_target(amt, target):
	target.hp -= int(rand_range(amt, amt*2))

# SLEEP - 50% chance to wake up per turn
# 		- always puts player to sleep
# 		- can't last longer than 6 turns

# STOPSPELL - 50% chance of working against player
#			- ??? same cure rate as sleep ???

# sleep - sleep_target
# hurt - hurt_target
# glow - outside only
# stopspell - stop_target_spells
# healmore - heal_self
# hurtmore - hurt_target

enum TURN {
	PLAYER,
	ENEMY
}

#move all player stuff into this object
var PLAYER = {
	"name" : "jp00p",
	"level" : 5,
	"strength" : 5,
	
	"max_hp" : 25,
	"hp" : 5,
	"max_mp" : 5,
	"mp": 3,
	"exp" : 24,
	"gold" : 31,
	"known_spells": ["heal", "hurt"]
}

var PLAYER_NAME = "jp00p"
var PLAYER_LEVEL = 5
var PLAYER_MAX_HP = 25
var PLAYER_MAX_MP = 5
var PLAYER_HP = PLAYER_MAX_HP
var PLAYER_MP = PLAYER_MAX_MP
var PLAYER_EXP = 123
var PLAYER_GOLD = 31
var KNOWN_SPELLS = ["heal", "hurt"]

# base stats
var PLAYER_STRENGTH = 10
var PLAYER_AGILITY = 10

var PLAYER_WEAPON = WEAPONS.club
var PLAYER_ARMOR = ARMORS.clothes
