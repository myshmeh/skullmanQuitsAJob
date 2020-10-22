extends Node2D

onready var inner_line: Sprite = $Frame/InnerLinePivot/InnerLine
onready var label: Label = $Label
export var elapsed_time_max: float = 5
signal on_timeout
var elapsed_time: float
var fully_elapsed: bool

func _ready():
	init_elapsed_time()

func _process(delta):
	elapsed_time = tick(elapsed_time, delta)
	elapsed_time = limit_elapsed_time(elapsed_time, elapsed_time_max)
	fully_elapsed = is_fully_elapsed_first_time(elapsed_time, elapsed_time_max, fully_elapsed)
	if fully_elapsed:
		emit_signal("on_timeout")
	var elapsed_time_rate: float = get_elapsed_time_rate(elapsed_time, elapsed_time_max)
	inner_line.region_rect = get_region_rect(elapsed_time_rate, inner_line.texture)
	inner_line.position.x = get_inner_line_position_x(elapsed_time_rate, inner_line.texture)

func tick(current_time_elapsed: float, millisecond: float) -> float:
	current_time_elapsed += millisecond
	return current_time_elapsed

func is_fully_elapsed_first_time(elapsed_time: float, elapsed_time_max: float, fully_elapsed: bool) -> bool:
	return elapsed_time >= elapsed_time_max and !fully_elapsed
	
func limit_elapsed_time (elapsed_time: float, elapsed_time_max: float) -> float:
	if elapsed_time >= elapsed_time_max:
		elapsed_time = elapsed_time_max
	return elapsed_time

func get_region_rect(elapsed_time_rate: float, inner_line_texture: Texture) -> Rect2:
	var region_rect: Rect2 = Rect2(0, 0, inner_line_texture.get_width() * elapsed_time_rate, inner_line_texture.get_height())
	return region_rect

func get_elapsed_time_rate(time_elapsed: float, elapsed_time_max: float) -> float:
	return time_elapsed / elapsed_time_max

func get_inner_line_position_x(elapsed_time_rate: float, inner_line_texture: Texture) -> float:
	return inner_line_texture.get_width() * elapsed_time_rate * 0.5

func init_elapsed_time():
	elapsed_time = 0
	fully_elapsed = false
