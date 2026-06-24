@tool
extends BTAction

@export var animation_name:String

func _generate_name() -> String:
	return "ChangeAnimation"

func _tick(_delta: float) -> Status:
	var owner:CharacterBody2D = blackboard.get_var("bb_owner")
	
	if not owner.has_method("play_animation"):
		return FAILURE
	
	owner.play_animation(animation_name)
	
	return SUCCESS
