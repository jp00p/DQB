extends CanvasLayer

signal spell_panel_closed
signal cast_spell

onready var spell_list = $Panel/VBoxContainer/MarginContainer/GridContainer

func _ready():
	for spell in Globals.KNOWN_SPELLS:
		# list our spellbook
		var l = load("res://UI/CommandLabel.tscn").instance()
		l.text = str(" "+Globals.SPELLS[spell].name).to_upper()
		l.command = spell
		l.connect("command_selected", self, "spell_selected") # when they select a spell
		spell_list.add_child(l)
	if spell_list.get_child_count() > 0:
		spell_list.get_child(0).grab_focus()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		emit_signal("spell_panel_closed")
		queue_free()

func spell_selected(spell_name):
	# cast that spell! (send signal to combat screen
	emit_signal("cast_spell", spell_name, "player")
