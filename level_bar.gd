@tool
extends Node2D

@export var dimensions: Vector2 = Vector2(200, 50)
@export var min_value: float = 0
@export var max_value: float = 100
@export var border_color: Color = Color.WHITE
@export var bar_color: Color = Color.SEA_GREEN

var value: float = 50
const border: float = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	var pct: float = (value - min_value) / (max_value - min_value)
	const half_border: float = border / 2
	draw_rect(Rect2(half_border, half_border, dimensions.x, dimensions.y), border_color, false, border)
	
	if (pct > 0):
		var width = pct * (dimensions.x - border)
		var height = dimensions.y - border
		draw_rect(Rect2(border, border, width, height), bar_color, true)

func reset():
	value = 0
	queue_redraw()

func adjust_value(by: float):
	value += by
	if (value > max_value):
		value = max_value
	if (value < min_value):
		value = min_value
	print("adjusting by: " + str(by) + "  to: " + str(value))
	queue_redraw()
