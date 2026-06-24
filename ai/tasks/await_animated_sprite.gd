@tool
extends BTAction

@export var bb_animated_sprite_name:String

var is_awaiting_aniamtion:bool = true
var is_signal_connected:bool = false

func _generate_name() -> String:
	return "AwaitAnimation"
	
func _enter() -> void:
	is_awaiting_aniamtion = true
	is_signal_connected = false

func _tick(_delta: float) -> Status:
	var animated_sprite:AnimatedSprite2D = blackboard.get_var(bb_animated_sprite_name)
	
	if not is_awaiting_aniamtion:
		if animated_sprite.animation_finished.is_connected(animation_finished):
			animated_sprite.animation_finished.disconnect(animation_finished)
		return SUCCESS
	
	if not is_signal_connected:
		if not animated_sprite.animation_finished.is_connected(animation_finished):
			animated_sprite.animation_finished.connect(animation_finished)
		is_signal_connected = true
	
	return RUNNING
	
func animation_finished() -> void:
	is_awaiting_aniamtion = false
