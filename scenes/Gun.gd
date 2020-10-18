extends Node2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var raycast: RayCast2D = $RayCast2D
export var power = 1
var shootable: bool

signal on_shot_collided(position)

func _ready():
	shootable = true
	visible = false

func shoot():
	if !shootable:
		return
	shootable = false
	visible = true
	if raycast.is_colliding():
		var object = raycast.get_collider()
		if object.has_method("take_hit"):
			object.take_hit(power)
		emit_signal("on_shot_collided", raycast.get_collision_point())
	animation_player.play("Shoot")

func enable_shoot():
	shootable = true

func hide():
	visible = false
