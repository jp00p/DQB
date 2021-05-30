extends TextureRect

export var enemy_name = "BaseEnemy"
export var strength = 0
export var agility = 0
export var max_hp = 0
export var max_mp = 0
export var xp = 0
export var gold = 0
var hp = max_hp
var mp = max_mp

func _ready():
	print(enemy_name)
