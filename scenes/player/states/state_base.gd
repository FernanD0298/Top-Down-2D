extends Node
class_name StateBase

@onready var controlled_node:Node = self.owner

var state_machine:StateMachine
var states:PlayerStatesNames = PlayerStatesNames.new()

signal state_transition

func Enter() -> void:
	pass

func Exit() -> void:
	pass
	
func Update(_delta:float) -> void:
	pass
	
func Physics_Update(_delta:float) -> void:
	pass
