extends StateBase
class_name HurtState

@export var audio_data:AudioData
var player:Player

func _ready() -> void:
	player = controlled_node as Player

func Enter() -> void:
	player.move(Vector2.ZERO)
	
	player.play_animation("Hit")
	player.change_audio(audio_data.hurt_sound)
	player.play_audio()
	player.hit_animation.animation_finished.connect(_on_Animation_finished)

func Exit():
	if player.hit_animation.animation_finished.is_connected(_on_Animation_finished):
		player.hit_animation.animation_finished.disconnect(_on_Animation_finished)

func Physics_Update(_delta:float):
	apply_knockback()

func _on_Animation_finished(_anim_name:String) -> void:
	state_transition.emit(states.Idle_State)

func apply_knockback() -> void:
	player.apply_knockback()
