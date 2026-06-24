extends BTState

@export var state_owner:Enemy
@export var min_dist:float = 250.0
@export var audio_data:AudioData

var is_walking:bool = false

func _enter() -> void:
	state_owner.change_audio(audio_data.walk_sound)
	blackboard.set_var("is_walking", false)
	is_walking = false
	state_owner.stop_audio()
	state_owner.play_animation("Idle")

func walking() -> void:
	state_owner.play_audio()
	is_walking = true

func _update(_delta: float) -> void:
	if not NodeRefs.player_ref or not state_owner:
		return
	
	if blackboard.get_var("is_walking") and not is_walking:
		walking()
	if not blackboard.get_var("is_walking") and is_walking:
		state_owner.stop_audio()
		is_walking = false
	
	var distance:float = state_owner.global_position.distance_to(NodeRefs.player_ref.global_position)
	
	if distance < min_dist:
		get_root().dispatch("detect_target")
