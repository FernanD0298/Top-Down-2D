extends Node2D
class_name Main

@export var player:Player

const MAIN = preload("uid://cbxvr8s565s6n")

func _ready() -> void:
	NodeRefs.main = self
	
func _on_player_died() -> void:
	get_tree().call_deferred("reload_current_scene")
