extends "res://scripts/Item.gd"

export var value: int = 25
export var offset_y: float = -8
onready var potion_fx: Particles2D = $ItemInBattleField/PotionFx
var used: bool

func _ready():
	used = false

func _process(delta):
	if !potion_fx.emitting && used:
		queue_free()

func use(player: Node2D):
	item_in_ui.visible = false
	if !player.has_method("set_life"):
		return
	player.set_life(player.life + value)
	potion_fx.global_position = Vector2(player.global_position.x, player.global_position.y + offset_y)
	potion_fx.emitting = true
	used = true
