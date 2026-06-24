extends Camera2D
class_name CameraShake

@export var max_shake:float = 10.0
@export var shake_fade:float = 10.0

var shake_strenght:float = 0.0

func trigger_shake() -> void:
	shake_strenght = max_shake

func _process(delta: float) -> void:
	if shake_strenght > 0:
		shake_strenght = lerp(shake_strenght, 0.0, shake_fade * delta)
		offset = Vector2(randf_range(-shake_strenght, shake_strenght), randf_range(-shake_strenght, shake_strenght))
