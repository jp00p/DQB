extends Label

export var command = "fight"
signal command_selected

func _on_Fight_focus_entered():
	text = text.replace(" ", ">")
	$Timer.start()

func _on_Fight_focus_exited():
	text = text.replace(">", " ")
	$Timer.stop()

func _on_Timer_timeout():
	if text[0] == ">":
		text = text.replace(">", " ")
	else:
		text = text.replace(" ", ">")

func _on_Fight_gui_input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("command_selected", command)
