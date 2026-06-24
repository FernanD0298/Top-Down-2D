extends StateBase
class_name MoveState

@export var audio_data:AudioData

var player:Player

func _ready() -> void:
	player = controlled_node as Player

func Enter() -> void:
	player.play_animation("Run")
	player.change_audio(audio_data.walk_sound)
	player.play_audio()
	pass

func Physics_Update(_delta:float) -> void:
	var direction:Vector2 = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
	
	player.move(direction)
	
	if direction == Vector2.ZERO:
		state_transition.emit(states.Idle_State)
	
	if direction.x != 0.0:
		player.pivot.scale.x = sign(direction.x)
	
	if(Input.is_action_just_pressed("Attack")):
		state_transition.emit(states.Attack_State)
