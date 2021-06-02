extends Panel

onready var player_name = $VBoxContainer/Title/Label
onready var level = $VBoxContainer/MarginContainer/Stats/GridContainer/LvAmt
onready var hp = $VBoxContainer/MarginContainer/Stats/GridContainer/HpAmt
onready var mp = $VBoxContainer/MarginContainer/Stats/GridContainer/MpAmt
onready var gold = $VBoxContainer/MarginContainer/Stats/GridContainer/GAmt
onready var xp = $VBoxContainer/MarginContainer/Stats/GridContainer/EAmt

func _ready():
	player_name.text = str(PLAYER.NAME).substr(0,4)
	level.text = str(PLAYER.level)
	hp.text = str(PLAYER.hp)
	mp.text = str(PLAYER.mp)
	gold.text = str(PLAYER.gold)
	xp.text = str(PLAYER.xp)
	
	PLAYER.connect("player_hp_changed", self, "update_player_hp")
	PLAYER.connect("player_mp_changed", self, "update_player_mp")
	
func update_player_hp(val):
	hp.text = str(val)

func update_player_mp(val):
	mp.text = str(val)
