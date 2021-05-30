extends TextureRect

export var enemy_name = "BaseEnemy"
export var strength = 0
export var agility = 0
export var max_hp = 0
export var max_mp = 0
export var dodge = 0
export var xp = 0
export var gold_min = 0
export var gold_max = 0
var hp = max_hp
var mp = max_mp


# attack pattern
# sleep/stop/hurt resist
# dodge


func _ready():
	print(enemy_name)
