extends CanvasLayer
class_name HUD

const HEARTH_VALUE:int = 1
const HEARTH_FULL = preload("uid://dwybjxlntrow6")
const HEARTH_EMPTY = preload("uid://dhvowyr0cysmq")

@onready var fade_overlay: ColorRect = $FadeOverlay
@onready var hearth_container: HBoxContainer = $HearthContainer
@onready var enemy_count: Label = $EnemyCountContainer/EnemyCount

@export var fade_duration:float = 1.5

signal fade_finished

func _ready() -> void:
	NodeRefs.hud_ref = self
	fade(0.0)

func update_health(new_health:int) -> void:
	var hearths:Array[Node] = hearth_container.get_children()
	@warning_ignore("integer_division")
	var full_hearths:int = int(new_health / HEARTH_VALUE)
	
	var index:int = 0
	for hearth in hearths:
		if index < full_hearths:
			hearth.texture = HEARTH_FULL
		else:
			hearth.texture = HEARTH_EMPTY
		index += 1

func fade(to_alpha:float) -> void:
	var tween:Tween = create_tween()
	tween.tween_property(fade_overlay, "modulate:a", to_alpha, fade_duration)
	await tween.finished
	fade_finished.emit()
	
func update_enemy_counter() -> void:
	var count:int = int(enemy_count.text)
	count += 1
	enemy_count.text = str(count)
