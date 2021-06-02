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

# SLEEP - 50% chance to wake up per turn
# 		- always puts player to sleep
# 		- can't last longer than 6 turns

# STOPSPELL - 50% chance of working against player
#			- ??? same cure rate as sleep ???

# sleep - sleep_target
# hurt - hurt_target
# stopspell - stop_target_spells
# healmore - heal_self
# hurtmore - hurt_target

enum TURN {
	PLAYER,
	ENEMY
}
