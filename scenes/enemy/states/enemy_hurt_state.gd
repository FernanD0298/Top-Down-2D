extends BTState

@export var state_owner:Enemy
@export var audio_data:AudioData

func _enter() -> void:
	state_owner.change_audio(audio_data.hurt_sound)
	state_owner.play_audio()
	blackboard.set_var("hit", true)

func _update(_delta: float) -> void:
	state_owner.apply_knockback()
	
	if not blackboard.get_var("hit"):
		get_root().dispatch("recover")
