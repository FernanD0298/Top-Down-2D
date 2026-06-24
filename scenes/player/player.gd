extends CharacterBody2D
class_name Player

@onready var pivot: Node2D = $Pivot
@onready var animated_sprite_2d: AnimatedSprite2D = $Pivot/AnimatedSprite2D
@onready var hit_box: HitBox = $Pivot/HitBox
@onready var state_machine: StateMachine = $StateMachine
@onready var hurt_box: HurtBox = $HurtBox
@onready var hit_animation: AnimationPlayer = $HitAnimation
@onready var health_component: HealthComponent = $HealthComponent
@onready var camera_2d: CameraShake = $Camera2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var speed:float = 200.0

var states:PlayerStatesNames = PlayerStatesNames.new()

func _ready() -> void:
	NodeRefs.player_ref = self
	NodeRefs.hud_ref.update_health(health_component.current_health)
	health_component.damaged.connect(_on_damaged)
	health_component.died.connect(_on_died)

func move(direction:Vector2) -> void:
	velocity = direction * speed
	move_and_slide()
	
func attack() -> void:
	hit_box.set_active(true)
	
func attack_finished() -> void:
	hit_box.set_active(false)
	
func play_audio() -> void:
	audio_stream_player_2d.play()
	
func stop_audio() -> void:
	audio_stream_player_2d.stop()
	
func change_audio(new_sound:AudioStream) -> void:
	audio_stream_player_2d.stream = new_sound

func play_animation(animation_name:String) -> void:
	if animation_name == "Hit":
		hit_animation.play("Hit")
	else:
		animated_sprite_2d.play(animation_name)
	
func apply_knockback() -> void:
	velocity = hurt_box.knockback_direction * hurt_box.knockback_force
	move_and_slide()
	
func _on_damaged(_amount:int) -> void:
	camera_2d.trigger_shake()
	state_machine.change_state(states.Hurt_State)
	NodeRefs.hud_ref.update_health(health_component.current_health)
	
func _on_died() -> void:
	state_machine.change_state(states.Dead_State)
	
func disabled_health_component() -> void:
	if health_component.damaged.is_connected(_on_damaged):
		health_component.damaged.disconnect(_on_damaged)
	
	if health_component.died.is_connected(_on_died):
		health_component.died.disconnect(_on_died)
