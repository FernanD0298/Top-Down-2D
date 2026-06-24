extends BTState

@export var state_owner:Enemy
@export var min_dist:float = 250.0
@export var audio_data:AudioData

func _enter() -> void:
	state_owner.stop_audio()
	state_owner.change_audio(audio_data.attack_sound)
	state_owner.play_audio()
	state_owner.attack()
	blackboard.set_var("aniamted_sprite", state_owner.animated_sprite_2d)

func _exit() -> void:
	state_owner.stop_audio()
	state_owner.finished_attack()
	
func change_attack(active:bool) -> void:
	if active:
		state_owner.attack()
	else:
		state_owner.play_audio()
		state_owner.finished_attack()

func _update(_delta: float) -> void:
	if not NodeRefs.player_ref or not state_owner:
		return
		
	var is_attack_finished:bool
	is_attack_finished = blackboard.get_var("attack_finished")
	change_attack(is_attack_finished)
	
	var player_position:Vector2 = NodeRefs.player_ref.global_position
	
	blackboard.set_var("target_position", player_position)
	var distance:float = state_owner.global_position.distance_to(player_position)
	
	if distance > min_dist:
		get_root().dispatch("detect_target")
