extends Area2D
class_name HurtBox

@export var health:HealthComponent

var knockback_direction:Vector2
var knockback_force:float

func _hit_receive(damaged:int, hit_direction:Vector2, hit_force:float) -> void:
	knockback_direction = hit_direction
	knockback_force = hit_force
	health.take_damage(damaged)
