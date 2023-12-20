@tool
class_name LevelBar
extends Node2D
## a UI element showing a level bar, displaying some level between the min and max
##
## use reset() to set the level to the min
## use adjust_level(by) to adjust the current level; it will be bounded by the configured min and max
## use set_level(to) to set the level; it will be bounded by the configured min and max


const border: float = 2


## control's visual screen dimensions
@export var dimensions: Vector2 = Vector2(200, 50)
## control's visual border color
@export var border_color: Color = Color.WHITE
## control's visual level bar color
@export var bar_color: Color = Color.SEA_GREEN

## min value for the level
@export var min_level: float = 0
## max value for the level
@export var max_level: float = 100


## current level
var _level: float = 50

## keep the current level within the min and max
func _bound_level():
	if (_level > max_level):
		_level = max_level
	if (_level < min_level):
		_level = min_level


func _draw():
	var pct: float = (_level - min_level) / (max_level - min_level)
	const half_border: float = border / 2
	draw_rect(Rect2(half_border, half_border, dimensions.x, dimensions.y), border_color, false, border)
	
	if (pct > 0):
		var width = pct * (dimensions.x - border)
		var height = dimensions.y - border
		draw_rect(Rect2(border, border, width, height), bar_color, true)


## set the level to the min_level
func reset():
	_level = min_level
	queue_redraw()


## adjust the current level by [by], bounded by min and max
func adjust_level(by: float):
	_level += by
	_bound_level()
	queue_redraw()


## set the current level to [to], bounded by min and max
func set_level(to: float):
	_level = to
	_bound_level()
	queue_redraw()
