extends RigidBody2D

signal value_available(score: int, color: Color)

@export var value: int = 1
@export var color: Color = Color(1, 1, 1, 1)

func gobbled():
	value_available.emit(value, color)
	queue_free()

func wasted():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	print(name + " exited")
	wasted()

func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, color)
