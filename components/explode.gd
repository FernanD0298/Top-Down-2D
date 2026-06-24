extends Node2D
class_name ExplodeParticles

@onready var cpu_particles_2d: CPUParticles2D = $CPUParticles2D

func active() -> void:
	cpu_particles_2d.emitting = true

func connect_finish_particles(function:Callable) -> void:
	cpu_particles_2d.finished.connect(function)
