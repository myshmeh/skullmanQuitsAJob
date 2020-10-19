extends Node2D

export var start_pure_position_x: int = 1
export var start_pure_position_y: int = 1
export var life_max: int = 50
onready var gun = $Gun
onready var life_indicator = $LifeIndicator
var life: int
var velocity: Vector2
var pure_position: Vector2
var offset_position: Vector2
signal attack_collided(position)
signal use_item()

func _ready():
	velocity = Vector2.ZERO
	pure_position = Vector2(start_pure_position_x, start_pure_position_y)
	offset_position = Vector2.ZERO
	life = life_max
	life_indicator.text = String(life)

func _process(delta):
	velocity = translate_input_to_velocity()
	pure_position += velocity
	pure_position = bind_pure_position(pure_position, Global.TILE_NUM_X, Global.TILE_NUM_Y)
	position = amplify_pure_position(pure_position, offset_position, Global.TILE_WIDTH)
	if Input.is_action_just_pressed("use_item"):
		emit_signal("use_item")
	if Input.is_action_just_pressed("ui_accept"):
		gun.shoot()

func translate_input_to_velocity() -> Vector2:
	var velocity = Vector2.ZERO
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -1
	if Input.is_action_just_pressed("ui_down"):
		velocity.y = 1
	if Input.is_action_just_pressed("ui_left"):
		velocity.x = -1
	if Input.is_action_just_pressed("ui_right"):
		velocity.x = 1
	return velocity

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

func _on_Player_body_entered(body):
	emit_signal("attack_collided", position)
	take_hit(body.power)

func take_hit(power: int):
	life = apply_damage(life, power)
	set_life_indicator_text(String(life))
	if life == 0:
		die()

func apply_damage(life:int, damage: int) -> int:
	return int(clamp(life - damage, 0, 999))

func set_life(value: int):
	life = value
	set_life_indicator_text(String(life))

func set_life_indicator_text(text: String):
	life_indicator.text = text

func die():
	print("player is dead")
