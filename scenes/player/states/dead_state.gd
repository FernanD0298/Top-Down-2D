extends StateBase
class_name DeadState

@export var audio_data:AudioData

var player:Player

const EXPLODE = preload("uid://bwps4ikhmmhpt")

func _ready() -> void:
	player = controlled_node as Player
	
func Enter() -> void:
	player.move(Vector2.ZERO)
	player.set_physics_process(false)
	
	player.change_audio(audio_data.explosion_sound)
	player.play_audio()
	
	NodeRefs.hud_ref.fade_finished.connect(fade_finished)
	
	player.visible = false
	player.disabled_health_component()
	
	var particles:ExplodeParticles = EXPLODE.instantiate()
	particles.global_position = player.global_position
	call_deferred("add_child", particles)
	particles.call_deferred("active")
	particles.call_deferred("connect_finish_particles", explode_finished)
	
func explode_finished() -> void:
	NodeRefs.hud_ref.fade(1.0)
	
func fade_finished() -> void:
	NodeRefs.main._on_player_died()
