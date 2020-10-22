extends Node

export var type_key = 'item'
export var num = 2
const type_dict: Dictionary = {
	"item": Global.Selectables.ITEM,
	"item_box": Global.Selectables.ITEM_BOX
}
var type

func _ready():
	if !type_dict.has(type_key):
		printerr(type_key, " is invalid key. set type_key from the following: ", type_dict.values())
		return
	type = type_dict.get(type_key)

func is_item_box() -> bool:
	return type == Global.Selectables.ITEM_BOX

func attach_item(inst: Node):
	if !is_item_box():
		printerr("can't attach ", inst.name, " to this object")
	add_child(inst)

func detach_item(target_name: String):
	var children = get_children()
	for c in children:
		if c.name == target_name:
			c.queue_free()
