extends Node

const TILE_WIDTH: int = 16
export var start_pure_position_x: int = 1
export var start_pure_position_y: int = 1
var velocity: Vector2
var pure_position: Vector2
var offset_position: Vector2

func _ready():
	velocity = Vector2.ZERO
	pure_position = Vector2(start_pure_position_x, start_pure_position_y)
	offset_position = Vector2.ZERO
