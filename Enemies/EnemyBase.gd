extends TextureRect

class_name Enemy

signal enemy_hp_changed
signal enemy_died
signal enemy_animation_finished

export var NAME = "BaseEnemy"
export var strength = 0
export var agility = 0
export var max_hp = 0
export var max_mp = 0
export var dodge = 0
export var xp = 0
export var gold_min = 0
export var gold_max = 0
var hp = max_hp setget set_enemy_hp
var mp = max_mp
export var move_list = ["attack"]

# 25% chance to heal (at 1/4 health)
# 50% chance to cast hurt
# attack

func get_attack_pattern():
	return move_list
	
func hit_animation():
	$AnimationPlayer.play("hit")
	
func play_appear_anim():
	$AnimationPlayer.play("appear")

func set_enemy_hp(val):
	hp = clamp(0, val, max_hp)
	emit_signal("enemy_hp_changed", hp)
	if hp <= 0:
		emit_signal("enemy_died")


func _on_AnimationPlayer_animation_finished(anim_name):
	emit_signal("enemy_animation_finished")
