class_name BounceBackZone
extends Area2D
## Drawing support for the bounce back zones, the weird physics areas


func _draw():
	var s = $CollisionShape2D.shape.size
	draw_rect(Rect2(Vector2.ZERO - (s / 2), s), Color(1, 1, 1, 0.1), false, 4)
