extends Node2D
class_name SpawnController

const ENEMY_REF = preload("uid://cxi532aj25r5e")
const TIME_TO_SPAWN_ENEMY:float = 1.5

@export var spawn_points:Array[Node2D]
@export var navigation_map:NavigationRegion2D
@export var initial_spawn:int = 2

var spawn_index:int = 0
var total_spawns:int 

func _ready() -> void:
	total_spawns = len(spawn_points)
	for i in initial_spawn:
		spawn_enemy()

func spawn_enemy() -> void:
	if total_spawns == 0:
		return
		
	var enemy:Enemy = ENEMY_REF.instantiate()
	enemy.global_position = spawn_points[spawn_index].global_position
	enemy.nav_region = navigation_map
	call_deferred("add_child", enemy)
	enemy.call_deferred("connect_health_signal", enemy_eliminated)
	
	if spawn_index == total_spawns - 1:
		spawn_index = 0
		return
	
	spawn_index += 1

func enemy_eliminated() -> void:
	NodeRefs.hud_ref.update_enemy_counter()
	await get_tree().create_timer(TIME_TO_SPAWN_ENEMY).timeout
	spawn_enemy()
