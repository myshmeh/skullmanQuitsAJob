extends Node

var width: int
var height: int
export var pointer: int = 0
export var zoom_interval: float = 0.5
export var zoom_scale: float = 1.1
var time: float = 0.0
var zoomed: bool = false

func _process(delta):
	time += delta
	if time > zoom_interval && !zoomed:
		time = 0.0
		zoomed = true
		self.rect_scale = Vector2.ONE * zoom_scale
	elif time > zoom_interval && zoomed:
		time = 0.0
		zoomed = false
		self.rect_scale = Vector2.ONE

# call this before using any other custom methods here
func init(width: int, height: int, initial_pointer_val: int):
	self.width = width
	self.height = height
	self.pointer = initial_pointer_val

func move_up():
	if pointer - width < 0:
		pointer = width * (height - 1) + pointer % width
		return
	pointer -= width

func move_down():
	if pointer + width > width * height - 1:
		pointer = pointer % width
		return
	pointer += width

func move_left():
	if pointer % width == 0:
		pointer += width - 1
		return
	pointer -= 1

func move_right():
	if pointer % width == width - 1:
		pointer -= width - 1
		return
	pointer += 1

func to_vec2() -> Vector2:
	return Vector2(pointer % width, pointer / width)
