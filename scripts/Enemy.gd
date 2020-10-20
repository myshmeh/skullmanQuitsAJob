extends Area2D

export var start_pure_position_x: int = 1
export var start_pure_position_y: int = 1
export var life_max: int = 10
onready var life_indicator = $LifeIndicator
var life: int
var velocity: Vector2
var pure_position: Vector2
var offset_position: Vector2
signal enemy_dead(position)

func _ready():
	velocity = Vector2.ZERO
	pure_position = Vector2(start_pure_position_x, start_pure_position_y)
	offset_position = Vector2.ZERO
	life = life_max
	life_indicator.text = String(life)

func bind_pure_position(pure_position: Vector2, tile_xdir_num: int, tile_ydir_num: int) -> Vector2:
	if pure_position.y < 0:
		pure_position.y = 0
	if pure_position.y > tile_ydir_num - 1:
		pure_position.y = tile_ydir_num - 1
	if pure_position.x < 0:
		pure_position.x = 0
	if pure_position.x > tile_xdir_num - 1:
		pure_position.x = tile_xdir_num - 1
	return pure_position

func amplify_pure_position(pure_position: Vector2, offset_position: Vector2, tile_width: int) -> Vector2:
	return Vector2(
		offset_position.x + pure_position.x * tile_width,
		offset_position.y + pure_position.y * tile_width
	)

func take_hit(power: int):
	life = apply_damage(life, power)
	life_indicator.text = String(life)
	if life == 0:
		emit_signal("enemy_dead", global_position)
		queue_free()

func apply_damage(life:int, damage: int) -> int:
	return int(clamp(life - damage, 0, life_max))

func _on_Enemy_body_entered(body):
	if !body.has_method("get_power"):
		printerr(body.name, " does not have a method 'get_power'. consider to extend the Damagable.gd script")
		return
	take_hit(body.get_power())
	if !body.has_method("do_after_damaged"):
		printerr(body.name, " does not have a method 'do_after_damaged'. consider to extend the Damagable.gd script")
		return
	body.do_after_damaged()
