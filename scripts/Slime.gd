extends "res://scripts/Enemy.gd"

# 1 (down) or -1 (up)
var facing_down: int

func _ready():
	facing_down = 1

func _process(delta):
	pass

func _on_Timer_timeout():
	velocity.y = sign(facing_down)
	pure_position += velocity
	if pure_position.y >= Global.TILE_NUM_Y - 1 || pure_position.y <= 0:
		facing_down *= -1
	pure_position = bind_pure_position(pure_position, Global.TILE_NUM_X, Global.TILE_NUM_Y)
	position = amplify_pure_position(pure_position, offset_position, Global.TILE_WIDTH)
