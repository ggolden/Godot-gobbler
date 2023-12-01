extends Area2D

func _draw():
	print("drawing " + name)
	var s = $CollisionShape2D.shape.size
	draw_rect(Rect2(Vector2.ZERO - (s / 2), s), Color(1, 1, 1, 0.1), false, 4)
