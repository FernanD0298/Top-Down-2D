extends Area2D
class_name HitBox

@export var damage:int = 1 : set = set_damage, get = get_damage
@export var hit_force:float = 200.0

func _ready() -> void:
	area_entered.connect(_on_area_2d_body_entered)
	set_active(false)

func set_active(active:bool) -> void:
	for child in get_children():
		if child is not CollisionShape2D: continue
		child.set_deferred("disabled", not active)

func set_damage(value:int) -> void:
	damage = value
	
func get_damage() -> int:
	return damage
	
func _on_area_2d_body_entered(area:Area2D) -> void:
	if area.has_method("_hit_receive"):
		var knockback_direction:Vector2 = (area.global_position - global_position).normalized()
		area._hit_receive(get_damage(), knockback_direction, hit_force)
