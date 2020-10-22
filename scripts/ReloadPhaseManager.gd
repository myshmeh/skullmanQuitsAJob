extends Node

onready var bomb = preload("res://scenes/BombInReloadScene.tscn")
onready var potion = preload("res://scenes/PotionInReloadScene.tscn")
onready var invincible_suit = preload("res://scenes/InvincibleSuitInReloadScene.tscn")
onready var item_box_container = $UI/ItemBoxContainer
onready var item_container = $UI/ItemContainer
onready var pointer = $Pointer
onready var description_label = $UI/Description/Label
onready var guide_label = $UI/Guide/Label
var selectables: Array
var item_boxes: Array
var all_selected: bool

func _ready():
	selectables = [[], []]
	for item in item_container.get_children():
		selectables[Global.Selectables.ITEM].push_back(item)
		item.get_child(0).text = String(item.num)
	item_boxes = item_box_container.get_children()
	for item_box in item_boxes:
		selectables[Global.Selectables.ITEM_BOX].push_back(item_box)
	pointer.init(selectables[0].size(), selectables.size(), 3)
	guide_label.text = Global.ReloadPhaseGuides.not_all_selected
	all_selected = false

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		pointer.move_up()
		description_label.text = get_description(get_selectable(selectables, pointer))
	if Input.is_action_just_pressed("ui_down"):
		pointer.move_down()
		description_label.text = get_description(get_selectable(selectables, pointer))
	if Input.is_action_just_pressed("ui_left"):
		pointer.move_left()
		description_label.text = get_description(get_selectable(selectables, pointer))
	if Input.is_action_just_pressed("ui_right"):
		pointer.move_right()
		description_label.text = get_description(get_selectable(selectables, pointer))
	if Input.is_action_just_pressed("ui_accept"):
		var selectable = get_selectable(selectables, pointer)
		if selectable.type == Global.Selectables.ITEM_BOX && selectable.get_child_count() > 0:
			selectable.get_child(0).queue_free()
			var selectable_child = selectable.get_child(0)
			for item in item_container.get_children():
				print(item.name, selectable_child.name)
				if item.name != selectable_child.name:
					continue
				item.num += 1
				item.get_child(0).text = String(item.num)
			return
		if all_selected:
			Global.set_scene_parameter(get_selected_items(item_boxes))
			get_tree().change_scene("res://scenes/BattleField.tscn")
			return
		if selectable.type == Global.Selectables.ITEM && selectable.num > 0:
			for item_box in item_boxes:
				if item_box.get_child_count() > 0:
					continue
				var ins
				if selectable.name == Global.ItemNameDict.get(Global.Items.BOMB):
					ins = bomb.instance()
				if selectable.name == Global.ItemNameDict.get(Global.Items.POTION):
					ins = potion.instance()
				if selectable.name == Global.ItemNameDict.get(Global.Items.INVINCIBLE_SUIT):
					ins = invincible_suit.instance()
				item_box.add_child(ins)
				selectable.num -= 1
				if selectable.num < 0:
					selectable.num = 0
				selectable.get_child(0).text = String(selectable.num)
				return
	pointer.rect_global_position = get_pointer_position(pointer, selectables)
	
	if is_all_selected(item_boxes):
		all_selected = true
		guide_label.text = Global.ReloadPhaseGuides.all_selected
	else:
		all_selected = false
		guide_label.text = Global.ReloadPhaseGuides.not_all_selected

func is_all_selected(item_boxes: Array) -> bool:
	return get_selected_item_count(item_boxes) == item_boxes.size()
	
func get_selected_item_count(item_boxes: Array) -> int:
	var count: int = 0
	for item_box in item_boxes:
		if item_box.get_child_count() == 0:
			continue
		count += 1
	return count

# returns Items enum array
func get_selected_items(item_boxes: Array) -> Array:
	var items: Array = []
	for item_box in item_boxes:
		if item_box.get_child_count() == 0:
			continue
		items.push_back(Global.ItemNumDict.get(item_box.get_child(0).name))
	return items

func get_pointer_position(pointer: Control, selectables: Array) -> Vector2:
	var selectables_index = pointer.to_vec2()
	var selectable = selectables[selectables_index.y][selectables_index.x]
	var selectable_position = selectable.rect_global_position
	var selectable_size = selectable.rect_size * selectable.rect_scale * selectable.get_parent().rect_scale
	return Vector2(selectable_position.x + selectable_size.x * 0.5, selectable_position.y + selectable_size.y * 0.5)

func get_selectable(selectables: Array, pointer: Control) -> Control:
	var pointer_index = pointer.to_vec2()
	return selectables[pointer_index.y][pointer_index.x]

func get_description(selectable: Control) -> String:
	if selectable.type == Global.Selectables.ITEM:
		return Global.DESCRIPTIONS.get(selectable.name)
	if selectable.get_child_count() > 0:
		return "%s:\n%s is selected" % [selectable.name, selectable.get_child(0).name]
	return "%s:\nno item is selected" % selectable.name
