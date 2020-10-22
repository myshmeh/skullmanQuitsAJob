extends Node2D

const TILE_WIDTH: int = 16
const TILE_NUM_X: int = 3
const TILE_NUM_Y: int = 3
const BOMB_DAMAGE_VALUE: int = 5
const POTION_CURE_VALUE: int = 25
const INVINCIBLE_SUIT_DURATION: int = 5
enum Selectables {
	ITEM_BOX,
	ITEM
}
enum Items {
	BOMB,
	POTION,
	INVINCIBLE_SUIT
}
const ItemNameDict: Dictionary = {
	Items.BOMB: "Bomb",
	Items.POTION: "Potion",
	Items.INVINCIBLE_SUIT: "Invincible Suit"
}
const ItemNumDict: Dictionary = {
	"Bomb": Items.BOMB,
	"Potion": Items.POTION,
	"Invincible Suit": Items.INVINCIBLE_SUIT
}
const ReloadPhaseGuides: Dictionary = {
	"not_all_selected": "select 3 items",
	"all_selected": "press a button to start"
}
const DESCRIPTIONS: Dictionary = {
	"Bomb": "bomb:\nblows 3 vertical lines with %s LP damage." % BOMB_DAMAGE_VALUE,
	"Potion": "potion:\ncures %s LP." % POTION_CURE_VALUE,
	"Invincible Suit": "invincible suit:\ntakes no damage for %s seconds." % INVINCIBLE_SUIT_DURATION
}
var scene_parameter

func set_scene_parameter(value):
	scene_parameter = value

func get_scene_parameter():
	return scene_parameter

func instantiate_node(scene, node_position: Vector2) -> Node2D:
	var main = get_tree().current_scene
	var instance : Node2D = scene.instance()
	main.add_child(instance)
	instance.global_position = node_position
	return instance
