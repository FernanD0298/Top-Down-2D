extends StateBase
class_name IdleState

var player:Player

func _ready() -> void:
	player = controlled_node as Player

func Enter() -> void:
	player.play_animation("Idle")
	player.stop_audio()

func Physics_Update(_delta:float) -> void:
	if(Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")):
		state_transition.emit(states.Move_State)
	
	if(Input.is_action_just_pressed("Attack")):
		state_transition.emit(states.Attack_State)
