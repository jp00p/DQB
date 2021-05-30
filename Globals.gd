extends Node

enum TURN {
	PLAYER,
	ENEMY
}

var PLAYER_LEVEL = 5
var PLAYER_MAX_HP = 25
var PLAYER_MAX_MP = 5
var PLAYER_HP = PLAYER_MAX_HP
var PLAYER_MP = PLAYER_MAX_MP
var PLAYER_EXP = 123
var PLAYER_GOLD = 31

# base stats
var PLAYER_STRENGTH = 10
var PLAYER_AGILITY = 10


# attack formula: (Attack Strength – (Opponent Defense / 2)) / 2


var ENEMY_HP = 5
var ENEMY_DEFENSE = 5
