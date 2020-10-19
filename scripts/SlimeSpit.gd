extends RigidBody2D

export var x_speed: float = -0.75
export var power: int = 1

func _ready():
	pass

func _process(delta):
	move_local_x(x_speed)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
