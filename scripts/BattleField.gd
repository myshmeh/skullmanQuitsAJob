extends Node

onready var player_tiles_top_left = $PlayerTilesTopLeft
onready var enemy_tiles_top_left = $EnemyTilesTopLeft
onready var player = $Player
onready var gun = $Player/Gun
onready var enemy_wrapper = $EnemyWrapper
onready var item_boxes = $ItemBoxes
onready var explosion_particle = preload("res://scenes/Explosion.tscn")
onready var win_message = preload("res://scenes/WinMessage.tscn")
onready var potion = preload("res://scenes/Potion.tscn")
var won: bool
var items: Array

func _ready():
	gun.connect("attack_collided", self, "on_attack_collided")
	player.connect("attack_collided", self, "on_attack_collided")
	player.connect("use_item", self, "on_player_use_item")
	player.offset_position = player_tiles_top_left.position
	player.position = player.amplify_pure_position(player.pure_position, player.offset_position, Global.TILE_WIDTH)
	var enemies: Array = enemy_wrapper.get_children()
	for enemy in enemies:
		enemy.offset_position = enemy_tiles_top_left.position
		enemy.position = enemy.amplify_pure_position(enemy.pure_position, enemy.offset_position, Global.TILE_WIDTH)
		enemy.connect("enemy_dead", self, "on_Enemy_enemy_dead")
	won = false
	set_items([potion, potion, potion])

func _process(delta):
	if enemy_wrapper.get_child_count() == 0 && !won:
		win_battle()

func on_attack_collided(position: Vector2):
	var node = explosion_particle.instance()
	node.global_position = position
	add_child(node)

func set_items(item_scenes: Array):
	var item_boxes_children = item_boxes.get_children()
	var i: int = 0
	while (i < 3):
		items.push_back(Global.instantiate_node(item_scenes[i], item_boxes_children[i].global_position))
		i += 1
		
func on_Enemy_enemy_dead(position: Vector2):
	var node = explosion_particle.instance()
	node.global_position = position
	add_child(node)

func win_battle():
	Global.instantiate_node(win_message, Vector2.ZERO)
	won = true

func on_player_use_item():
	var item = items.pop_front()
	if item:
		item.use(player)
