class_name Gobble
extends RigidBody2D
## The gobble, the thing that gobblers love to gobble


## the signal the gobble emits when it has been gobbled
signal was_gobbled(value: int, color: Color)


## the color of the gobble
@export var color: Color = Color(1, 1, 1, 1)


func _draw():
	draw_circle(Vector2.ZERO, $CollisionShape2D.shape.radius, color)


func _on_visible_on_screen_notifier_2d_screen_exited():
	print(name + " wasted")
	_wasted()


func _physics_process(delta):
	if abs(linear_velocity.y) < 0.1:
		_fade(delta)


func value():
	return int(color.r + color.b + color.g) + 1


## the gobble was gobbled
func gobbled():
	was_gobbled.emit(value(), color)
	queue_free()


## fade the gobble by delta, detecting its demise
func _fade(delta):
	color = Color(
		move_toward(color.r, 0, delta/3),
		move_toward(color.g, 0, delta/3),
		move_toward(color.b, 0, delta/3),
		move_toward(color.a, 0, delta/5))
	if color.a < 0.0001:
		_wasted()
	queue_redraw()


## the gobble went away without being gobbled
func _wasted():
	queue_free()
