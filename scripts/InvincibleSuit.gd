extends "res://scripts/Item.gd"

onready var timer = $ItemInBattleField/Timer
var player

func _ready():
	timer.wait_time = Global.INVINCIBLE_SUIT_DURATION

func use(player: Node2D):
	item_in_ui.visible = false
	if !player.has_method("enable_invincible_body"):
		return
	player.enable_invincible_body()
	timer.start()
	self.player = player

func _on_Timer_timeout():
	queue_free()
	if !player.has_method("disable_invincible_body"):
		return
	player.disable_invincible_body()
