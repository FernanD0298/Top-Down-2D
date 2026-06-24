extends LimboHSM
class_name EnemyStateMachine

@export var start_state:LimboState

@onready var navigation_agent_2d: NavigationAgent2D = $"../NavigationAgent2D"
@onready var patrol: BTState = $Patrol
@onready var chase: BTState = $Chase
@onready var attack: BTState = $Attack
@onready var hurt: BTState = $Hurt
@onready var dead: BTState = $Dead

func _initialize_state_machine() -> void:
	add_transition(patrol, chase, "detect_target")
	add_transition(chase, patrol, "lose_target")
	add_transition(chase, attack, "try_attack")
	add_transition(attack, chase, "detect_target")
	add_transition(attack, hurt, "take_damage")
	add_transition(hurt, chase, "recover")
	add_transition(hurt, dead, "dead")
	
	initial_state = start_state
	initialize(self)
	set_active(true)

func link_blackboard_var(var_name:String, target_var:String, ) -> void:
	var hsm_bb:Blackboard = get_blackboard()
	var bt_bb:Blackboard = start_state.get_blackboard()
	hsm_bb.link_var(var_name, bt_bb, target_var)

func update_target_position(target:Vector2) -> void:
	navigation_agent_2d.set_target_position(target)
