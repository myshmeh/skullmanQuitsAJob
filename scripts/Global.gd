extends Node2D

var TILE_WIDTH: int = 16
var TILE_NUM_X: int = 3
var TILE_NUM_Y: int = 3

func instantiate_node(scene, node_position: Vector2) -> Node2D:
	var main = get_tree().current_scene
	var instance : Node2D = scene.instance()
	main.add_child(instance)
	instance.global_position = node_position
	return instance
