extends Node

onready var player_tiles_top_left = $PlayerTilesTopLeft
onready var enemy_tiles_top_left = $EnemyTilesTopLeft
onready var player = $Player
onready var gun = $Player/Gun
onready var enemy_wrapper = $EnemyWrapper
onready var explosion_particle = preload("res://scenes/Explosion.tscn")

func _ready():
	gun.connect("shot_collided", self, "on_Gun_shot_collided")
	player.offset_position = player_tiles_top_left.position
	player.position = player.amplify_pure_position(player.pure_position, player.offset_position, Global.TILE_WIDTH)
	var enemies: Array = enemy_wrapper.get_children()
	for enemy in enemies:
		enemy.offset_position = enemy_tiles_top_left.position
		enemy.position = enemy.amplify_pure_position(enemy.pure_position, enemy.offset_position, Global.TILE_WIDTH)
		enemy.connect("enemy_dead", self, "on_Enemy_enemy_dead")

func on_Gun_shot_collided(position: Vector2):
	var node = explosion_particle.instance()
	node.global_position = position
	add_child(node)

func on_Enemy_enemy_dead(position: Vector2):
	var node = explosion_particle.instance()
	node.global_position = position
	add_child(node)
