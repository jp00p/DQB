extends Panel

onready var level = $VBoxContainer/MarginContainer/Stats/GridContainer/LvAmt
onready var hp = $VBoxContainer/MarginContainer/Stats/GridContainer/HpAmt
onready var mp = $VBoxContainer/MarginContainer/Stats/GridContainer/MpAmt
onready var gold = $VBoxContainer/MarginContainer/Stats/GridContainer/GAmt
onready var xp = $VBoxContainer/MarginContainer/Stats/GridContainer/EAmt

func _ready():
	level.text = str(Globals.PLAYER_LEVEL)
	hp.text = str(Globals.PLAYER_HP)
	mp.text = str(Globals.PLAYER_MP)
	gold.text = str(Globals.PLAYER_GOLD)
	xp.text = str(Globals.PLAYER_EXP)
