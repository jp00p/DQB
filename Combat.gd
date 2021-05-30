extends CanvasLayer

onready var enemy_container = $Control/EnemyPanel/Center
var enemy

func _ready():
	
	
	enemy = load("res://Enemies/Slime.tscn").instance()
	enemy_container.add_child(enemy)
	var enemy_name = enemy.enemy_name
	yield(get_tree().create_timer(1), "timeout")
	$Control/TextPanel.queue_message("A "+str(enemy_name)+" draws near!")
	$Control/TextPanel.queue_message("Command?")
	
	
	$Control/CommandsPanel/VBoxContainer/MarginContainer/Commands/Fight.grab_focus()	
	
	
	for c in $Control/CommandsPanel/VBoxContainer/MarginContainer/Commands.get_children():
		c.connect("command_selected", self, "execute_player_command")
	
func execute_player_command(command):
	if command == "fight":
		$Control/TextPanel.queue_message("jp00p attacks!")
		$Control/TextPanel.queue_message("The slime's hit points have been reduced by 10.")
