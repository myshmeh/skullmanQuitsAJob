extends "res://scripts/Enemy.gd"

onready var slime_spit = preload("res://scenes/SlimeSpit.tscn")
var facing_down: int # 1 (down) or -1 (up)
var shootable: bool

func _ready():
	facing_down = 1
	shootable = true

func _process(delta):
	pass

func _on_MoveTimer_timeout():
	if is_on_vertical_edge(pure_position):
		facing_down *= -1
	velocity.y = sign(facing_down)
	pure_position += velocity
	pure_position = bind_pure_position(pure_position, Global.TILE_NUM_X, Global.TILE_NUM_Y)
	position = amplify_pure_position(pure_position, offset_position, Global.TILE_WIDTH)
	shoot()

func is_on_vertical_edge(pure_position: Vector2):
	return pure_position.y >= Global.TILE_NUM_Y - 1 || pure_position.y <= 0

func shoot():
	Global.instantiate_node(slime_spit, position)
