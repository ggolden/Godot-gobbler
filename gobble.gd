class_name Gobble
extends RigidBody2D
## The gobble, the thing that gobblers love to gobble


## the signal the gobble emits when it has been gobbled
signal was_gobbled(value: int, color: Color)


## the value of the gobble
@export var value: int = 1
## the color of the gobble
@export var color: Color = Color(1, 1, 1, 1)


func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, color)


func _on_visible_on_screen_notifier_2d_screen_exited():
	print(name + " wasted")
	_wasted()


## the gobble was gobbled
func gobbled():
	was_gobbled.emit(value, color)
	queue_free()


## the gobble went away without being gobbled
func _wasted():
	queue_free()
