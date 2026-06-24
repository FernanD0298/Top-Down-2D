extends Node
class_name HealthComponent

signal damaged(current: int)
signal died

@export var max_health:int = 100

var current_health:int

func _ready() -> void:
	current_health = max_health
	
func take_damage(amount:int) -> void:
	current_health -= amount
	damaged.emit(current_health)
	
	if current_health <= 0:
		died.emit()
