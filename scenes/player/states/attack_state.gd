extends StateBase
class_name AttackState

@export var audio_data:AudioData

var player:Player

func _ready() -> void:
	player = controlled_node as Player

func Enter() -> void:
	player.animated_sprite_2d.animation_finished.connect(_on_attack_finished)
	player.play_animation("Attack")
	player.change_audio(audio_data.hammer_attack_sound)
	player.play_audio()
	player.attack()

func Exit() -> void:
	if player.animated_sprite_2d.animation_finished.is_connected(_on_attack_finished):
		player.animated_sprite_2d.animation_finished.disconnect(_on_attack_finished)
	player.attack_finished()

func _on_attack_finished() -> void:
	state_transition.emit(states.Idle_State)
