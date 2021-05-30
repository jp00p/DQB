extends CanvasLayer

onready var textpanel = $Control/TextPanel
onready var enemy_container = $Control/EnemyPanel/Center
onready var commands_container = $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands
onready var fight_button = $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands/Fight

var enemy
var turn = "player"

enum COMBAT_STATE {
	PLAYER_TURN,
	ENEMY_TURN,
	PLAYER_WIN,
	PLAYER_DEATH,
	PLAYER_ESCAPE
}

enum CHARACTER_STATE {
	SLEEP,
	STOPPED
}

func _ready():
	randomize()
	
	load_enemy(Globals.ENEMIES.RedSlime)
	textpanel.queue_message("A "+str(enemy.enemy_name)+" draws near!")
	textpanel.queue_message("Command?")
	yield(textpanel, "text_finished_typing")
	toggle_controls(true) # enable controls
	
	for c in $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands.get_children():
		# connect our command signals to this script
		c.connect("command_selected", self, "execute_player_command")
	
func execute_player_command(command):
	if command == "fight":
		toggle_controls(false)
		handle_player_attack()
		
	if command == "run":
		pass
		#handle player run
	if command == "item":
		pass
		#open item  ui
	if command == "spell":
		# load spells UI, connect signals
		toggle_controls(false)
		var spells = load("res://UI/SpellPanel.tscn").instance()
		spells.connect("spell_panel_closed", self, "close_spell_panel")
		spells.connect("cast_spell", self, "cast_spell")
		$Control.add_child(spells)
		
	yield(textpanel, "text_finished_typing")
	toggle_controls(true)

func handle_player_attack():
	# attack formula: (Attack Strength – (Opponent Defense / 2)) / 2
	var attack_power = (Globals.PLAYER_STRENGTH + Globals.PLAYER_WEAPON.offense) - (enemy.agility / 2) / 2
	var attack_power_max = attack_power * 2
	#print("Min damage " + str(attack_power))
	#print("Max damage " + str(attack_power_max))
	var actual_damage = int(rand_range(attack_power, attack_power_max))
	
	textpanel.queue_message(Globals.PLAYER_NAME + " attacks!")
	textpanel.queue_message(Globals.PLAYER_NAME + " deals " + str(actual_damage) + " damage to the " + str(enemy.enemy_name) + "!")
	

func load_enemy(e):
	# load an enemy into the combat window
	# accepts one of the enemies from the GLOBALS list of enemies
	# which are already loaded
	enemy = e.instance()
	enemy_container.add_child(enemy)
	
func close_spell_panel():
	#when the spell panel is closed, re-enable the commands panel
	toggle_controls(true)

func toggle_controls(state):
	# enable/disable controls
	for c in commands_container.get_children():
		if state == false:
			# disable buttons
			c.release_focus()
			c.focus_mode = 0
		else:
			# enable buttons
			c.focus_mode = 2
			fight_button.grab_focus()

func cast_spell(spell_name, caster):
	var spell = Globals.SPELLS[spell_name]
	# check if caster has enough mp
	if caster == "player":
		pass
		# check player mp
	else:
		pass
		# check monster mp
	
	





# if turn is players:
# - allow focus/input
# - wait for input
# - perform command
	# - fight: deal damage
	# - item: open item ui...
	# - spell: open spell ui...
	# - run: attempt run
# disable focus/input after accepting
