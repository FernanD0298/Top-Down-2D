extends BTState

@export var state_owner:Enemy
@export var audio_data:AudioData

const EXPLODE = preload("uid://bwps4ikhmmhpt")

func _enter() -> void:
	state_owner.move(Vector2.ZERO)
	state_owner.set_physics_process(false)
	
	state_owner.change_audio(audio_data.explosion_sound)
	state_owner.play_audio()
	
	state_owner.visible = false
	state_owner.diseable()
	
	var particles:ExplodeParticles = EXPLODE.instantiate()
	particles.global_position = state_owner.global_position
	call_deferred("add_child", particles)
	particles.call_deferred("active")
	particles.call_deferred("connect_finish_particles", enemy_destroyed)

func enemy_destroyed() -> void:
	state_owner.queue_free()
