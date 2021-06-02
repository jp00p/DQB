extends Panel

# creates typewriter text effects!
# builds a queue of messages so they don't get out of order/jumbled while we type!

signal text_finished_typing

onready var text_log = $MarginContainer/Log

var message_queue := []
var printing := false # are we printing now?
var first_message = true # is this the first message ever?

func queue_message(msg):
	var s := "" # temp string
	if not first_message:
		s = "\n" + msg # add newlines to NOT the first message
	else:
		s = str(msg)
		first_message = false
	message_queue.push_back(s) # add string to the back of the queue

func type_message(msg):
	printing = true # we are printing now
	for letter in msg:
		yield(get_tree().create_timer(0.025), "timeout") # slight delay
		text_log.text += letter # add letter to textbox
	message_queue.pop_front() # remove message from queue
	printing = false # we are not printing anymore, ready for another!
	emit_signal("text_finished_typing")
	#if message_queue.size() == 0: # tell the rest of the game the queue is empty!
		

func _process(delta):
	if message_queue.size() > 0 and not printing:
		# if the queue is not empty 
		# and we're not typing a message right now
		# type a new message!
		type_message(message_queue[0])
