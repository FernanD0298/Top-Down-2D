extends CharacterBody2D
class_name Enemy

@export var speed:float = 180.0
@export var nav_region:NavigationRegion2D

@onready var animated_sprite_2d: AnimatedSprite2D = $Pivot/AnimatedSprite2D
@onready var pivot: Node2D = $Pivot
@onready var state_machine: EnemyStateMachine = $LimboHSM
@onready var hit_box: HitBox = $Pivot/HitBox
@onready var hurt_box: HurtBox = $HurtBox
@onready var health_component: HealthComponent = $HealthComponent
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var collision: CollisionShape2D = $Collision

func _ready() -> void:
	health_component.damaged.connect(_on_damaged)
	health_component.died.connect(_on_died)
	initialize_state_machine()

func initialize_state_machine() -> void:
	if not nav_region:
		return
		
	state_machine._initialize_state_machine()
	state_machine.link_blackboard_var("nav_region", "navigation_region")
	state_machine.link_blackboard_var("bb_owner", "bb_owner")
	state_machine.get_blackboard().set_var("bb_owner", self)
	state_machine.get_blackboard().set_var("nav_region", nav_region)

func move(_velocity:Vector2) -> void:
	velocity = _velocity * speed
	
	if _velocity.x != 0.0:
		pivot.scale.x = sign(_velocity.x)
	
	move_and_slide()

func play_animation(animation_name:String) -> void:
	animated_sprite_2d.play(animation_name)
	
func play_audio() -> void:
	audio_stream_player_2d.play()
	
func stop_audio() -> void:
	audio_stream_player_2d.stop()
	
func change_audio(new_sound:AudioStream) -> void:
	audio_stream_player_2d.stream = new_sound

func apply_knockback() -> void:
	velocity = hurt_box.knockback_direction * hurt_box.knockback_force
	move_and_slide()

func _on_damaged(_amount:int) -> void:
	state_machine.dispatch("take_damage")
	
func _on_died() -> void:
	state_machine.dispatch("dead")

func attack() -> void:
	hit_box.set_active(true)
	
func finished_attack() -> void:
	hit_box.set_active(false)
	
func diseable() -> void:
	collision.set_deferred("disabled", true)
	disable_health_component()
	
func disable_health_component() -> void:
	if health_component.damaged.is_connected(_on_damaged):
		health_component.damaged.disconnect(_on_damaged)
	
	if health_component.died.is_connected(_on_died):
		health_component.died.disconnect(_on_died)
		
func connect_health_signal(function:Callable) -> void:
	health_component.died.connect(function)
