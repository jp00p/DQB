extends CanvasLayer

onready var textpanel = $Control/TextPanel
onready var enemy_container = $Control/EnemyPanel/Center
onready var commands_container = $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands
onready var fight_button = $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands/Fight
onready var flash = $FlashEffect/AnimationPlayer

var enemy
var first_message = true

var screen_shake_duration = 0.0
var max_screen_shake_offset = Vector2(8,8)
var screen_shake_decay = 0.9
var screen_shake_power = 2

enum COMBAT_STATE {
	PLAYER_TURN,
	ENEMY_TURN,
	PLAYER_WIN,
	PLAYER_DEATH,
	PLAYER_ESCAPE
}

enum STATUS {
	SLEEP,
	STOPPED
}

var TURN = 0 # 1 = enemy turn

func _ready():
	randomize()
	$FlashEffect.set_visible(false)	
	load_enemy(Globals.ENEMIES.Slime)
	
	for c in $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands.get_children():
		# connect our command signals to this script
		c.connect("command_selected", self, "execute_player_command")

func _process(delta):
	if screen_shake_duration:
		screen_shake_duration = max(screen_shake_duration - screen_shake_decay * delta, 0)
		screen_shake()
	
func add_screen_shake(amt):
	# set screen shake to go for amt seconds
	screen_shake_duration = min(screen_shake_duration + amt, 1.0)

func screen_shake():
	# actually shake the screen
	var amt = pow(screen_shake_duration, screen_shake_power)
	offset.x = max_screen_shake_offset.x * amt * rand_range(-1, 1)
	offset.y = max_screen_shake_offset.y * amt * rand_range(-1, 1)
	enemy_container.rect_position.x = -offset.x 
	enemy_container.rect_position.y = -offset.y
	
func create_combat_message(msg):
	textpanel.queue_message(msg)
	
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
		spells.connect("spell_panel_closed", self, "spell_panel_closed")
		spells.connect("cast_spell", self, "cast_spell")
		$Control.add_child(spells)
		
	
	
	#toggle_controls(true)


func enemy_turn():
	for move in enemy.move_list:
		match move:
			# breaks in here are breaking the for loop, not the match
			"small_heal":
				if enemy.hp < (enemy.max_hp*0.25) and randf() <= 0.25:
					cast_spell("heal", enemy)
					break
			"cast_hurt":
				if randf() <= 0.5:
					cast_spell("hurt", enemy)
					break
			"attack":
				handle_enemy_attack()
				break
				
				
func player_turn():
	create_combat_message("It is your turn.")
	create_combat_message("Command?")
	yield(textpanel, "text_finished_typing")
	toggle_controls(true)
	
func end_turn():
	if enemy.hp > 0:
		enemy_turn()
	else:
		enemy_death()
	
func handle_enemy_attack():
	var attack_power = enemy.strength + 5
	PLAYER.hp -= attack_power
	create_combat_message(enemy.NAME + " deals " + str(attack_power) + " damage to you!")
	add_screen_shake(0.5)
	player_turn()

func handle_player_attack():
	create_combat_message(PLAYER.NAME + " attacks!")
	# attack formula: (Attack Strength – (Opponent Defense / 2)) / 2
	var attack_power = (PLAYER.strength + PLAYER.weapon.offense) - (enemy.agility / 2) / 2
	var attack_power_max = attack_power * 2
	#print("Min damage " + str(attack_power))
	#print("Max damage " + str(attack_power_max))
	yield(textpanel, "text_finished_typing")
	var actual_damage = int(rand_range(attack_power, attack_power_max))
	enemy.hp -= actual_damage
	enemy.hit_animation()
	create_combat_message(PLAYER.NAME + " deals " + str(actual_damage) + " damage to the " + str(enemy.NAME) + "!")
	end_turn()

func load_enemy(e):
	# load an enemy into the combat window
	# accepts one of the enemies from the GLOBALS list of enemies
	# which are already loaded
	if enemy:
		yield(textpanel, "text_finished_typing")
	enemy = e.instance()
	#enemy.connect("enemy_died", self, "enemy_death")
	enemy.play_appear_anim()
	enemy_container.add_child(enemy)
	yield(enemy, "enemy_animation_finished")
	create_combat_message("A "+str(enemy.NAME)+" draws near!")
	yield(textpanel, "text_finished_typing")
	player_turn()

	
func spell_panel_closed():
	#when the spell panel is closed, re-enable the commands panel
	toggle_controls(true)



func toggle_controls(state):
	# enable/disable controls
	
	$Control/CommandsPanel.set_visible(state)
	
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
	toggle_controls(false)
	flash.play("flash")
	var spell = Globals.SPELLS[spell_name]
	create_combat_message(caster.NAME + " chanted the spell of " + spell.name.to_upper() + "!")	
	yield(textpanel, "text_finished_typing")
	call(spell.effect[0], caster, spell.effect[1]) # the magic
	if caster is Player:
		enemy_turn()
	else:
		player_turn()


func determine_target(caster):
	# for offensive spells
	if caster is Enemy:
		# enemy always targets player
		return PLAYER
	else:
		# player always targets enemy
		return enemy

# spell functions
func heal_self(caster, amt):
	caster.hp += int(rand_range(amt, amt*2))
	
func hurt_target(caster, amt):
	var target = determine_target(caster)
	target.hp -= int(rand_range(amt, amt*2))

func enemy_death():
	yield(textpanel, "text_finished_typing")
	create_combat_message("Thou hast done well in defeating the " + enemy.NAME + "!")
	enemy_container.get_child(0).queue_free()
	enemy.queue_free()
	load_enemy(Globals.ENEMIES.RedSlime)


# if turn is players:
# - allow focus/input
# - wait for input
# - perform command
	# - fight: deal damage
	# - item: open item ui...
	# - spell: open spell ui...
	# - run: attempt run
# disable focus/input after accepting
