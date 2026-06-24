extends BTState

@export var state_owner:Enemy
@export var min_dist:float = 80.0
@export var max_dist:float = 400.0
@export var audio_data:AudioData

func _enter() -> void:
	state_owner.change_audio(audio_data.walk_sound)
	state_owner.play_audio()

func _update(_delta: float) -> void:
	if not NodeRefs.player_ref or not state_owner:
		return
	
	var player_position:Vector2 = NodeRefs.player_ref.global_position
	
	blackboard.set_var("target_position", player_position)
	var distance:float = state_owner.global_position.distance_to(player_position)
	
	if distance < min_dist:
		get_root().dispatch("try_attack")
	elif distance > max_dist:
		get_root().dispatch("lose_target")
