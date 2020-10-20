extends "res://scripts/Item.gd"

onready var explosion = preload("res://scenes/CollidableExplosion.tscn")
onready var target = $ItemInBattleField/Target
onready var top = $ItemInBattleField/Top
onready var bomb = $ItemInBattleField/Bomb
export var thrown_duration: float = 1.0
var thrown: bool
var elapsed: float

func _ready():
	thrown = false
	elapsed = 0.0
	item_in_battle_field.visible = false
	item_in_ui.visible = true

func _process(delta):
	if !thrown:
		return
	elapsed += delta
	if elapsed > thrown_duration:
		bomb.position = target.position
		land()
		return
	var elapsed_rate: float = elapsed / thrown_duration
	bomb.position.x = target.position.x * elapsed_rate
	bomb.position.y = top.position.y * sin(PI * elapsed_rate)

func use(player: Node2D):
	item_in_battle_field.visible = true
	item_in_battle_field.global_position = player.global_position
	item_in_ui.visible = false
	thrown = true

func land():
	for n in range(3):
		var x = bomb.global_position.x
		var y = bomb.global_position.y - Global.TILE_WIDTH + Global.TILE_WIDTH * n
		Global.instantiate_node(explosion, Vector2(x, y))
	queue_free()
