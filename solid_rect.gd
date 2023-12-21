@tool
class_name SolidRect
extends Node2D
## Drawing support: draws a solid rectangle in the child's CollisionShape2D dimensions


func _draw():
	var s = $CollisionShape2D.shape.size
	draw_rect(Rect2(Vector2.ZERO - (s / 2), s), Color(1, 0, 0, 0.5), true)
