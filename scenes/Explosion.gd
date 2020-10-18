extends Node2D

onready var particle = $Particles2D
var emitted: bool

func _ready():
	particle.emitting = true
	emitted = true
	print('emit')

func _process(delta):
	if !particle.emitting:
		queue_free()
