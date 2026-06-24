extends Node
class_name StateMachine

@onready var contolled_node = self.owner

@export var defaul_state:StateBase

var states:Dictionary = {}
var current_state:StateBase = null

func _ready() -> void:
	for child in get_children():
		if child is StateBase:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
	
	call_deferred("_state_default_start")

func _state_default_start() -> void:
	if defaul_state:
		current_state = defaul_state
		_state_start()

func _state_start() -> void:
	current_state.controlled_node = contolled_node
	current_state.state_machine = self
	current_state.Enter()
	
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)
		
func change_state(new_state_name:String) -> void:
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	current_state = new_state
