extends Node

onready var item_in_battle_field: Node2D = $ItemInBattleField
onready var item_in_ui: Node2D = $ItemInUI

func _ready():
	pass

func use(player: Node2D):
	print("override this function to use item")
