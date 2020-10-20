extends "res://scripts/Damagable.gd"

var damage_delegator: Node2D = null

func set_damage_delegator(value: Node2D):
	damage_delegator = value

func set_power(value: int):
	power = value

func do_after_damaged():
	if damage_delegator == null:
		printerr("damage_delegator is not set. yse 'set_damage_delegator()' to set it.")
		return
	damage_delegator.queue_free()
	
