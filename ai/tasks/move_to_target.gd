@tool
extends BTAction

@export var min_distance:float = 5.0
@export var balckboard_target:String

func _generate_name() -> String:
	return "MoveToTarget"

func _tick(_delta: float) -> Status:
	var target:Vector2 = blackboard.get_var(balckboard_target)
	var owner:CharacterBody2D = blackboard.get_var("bb_owner")
	var current_position:Vector2 = owner.global_position
	var next_position:Vector2 = agent.navigation_agent_2d.get_next_path_position()
	var new_velocity:Vector2 = (next_position - current_position).normalized()
	agent.update_target_position(target)
	
	if not owner.has_method("move"):
		return FAILURE
	
	owner.move(new_velocity)
	
	if owner.global_position.distance_to(target) < min_distance:
		return SUCCESS
		
	return RUNNING
