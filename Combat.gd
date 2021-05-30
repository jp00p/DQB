extends CanvasLayer

onready var textpanel = $Control/TextPanel
onready var enemy_container = $Control/EnemyPanel/Center
onready var commands_container = $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands
onready var fight_button = $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands/Fight

var enemy
var turn = "player"

func _ready():
	
	load_enemy(Globals.ENEMIES.Slime)
	textpanel.queue_message("A "+str(enemy.enemy_name)+" draws near!")
	textpanel.queue_message("Command?")
	toggle_controls(true)
	
	
	
	for c in $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands.get_children():
		c.connect("command_selected", self, "execute_player_command")
	
func execute_player_command(command):
	if command == "fight":
		toggle_controls(false)
		textpanel.queue_message("jp00p attacks!")
		textpanel.queue_message("The slime's hit points have been reduced by 10.")
		yield(textpanel, "text_finished_typing")
		toggle_controls(true)
		

func load_enemy(e):
	enemy = e.instance()
	enemy_container.add_child(enemy)


func toggle_controls(state):
	for c in commands_container.get_children():
		if state == false:
			c.release_focus()
			c.focus_mode = 0
		else:
			c.focus_mode = 2
			fight_button.grab_focus()



# if turn is players:
# - allow focus/input
# - wait for input
# - perform command
	# - fight: deal damage
	# - item: open item ui...
	# - spell: open spell ui...
	# - run: attempt run
# disable focus/input
