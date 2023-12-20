class_name Gobbler
extends CharacterBody2D
## Gobbler (player) controller


## player control turn rate in radians / second
@export var turn_rate = PI
## player control advance speed in units / second
@export var advance_rate = 222


var _reset_position = Vector2.ZERO
var _reset_rotation = 0


func _ready():
	_reset_position = position
	_reset_rotation = rotation

	
func _physics_process(delta):
	# turn based on player input
	rotation += _direction() * turn_rate * delta
	
	# advance based on player input
	var collision = move_and_collide(_velocity() * advance_rate * delta)
	
	# handle reset
	if (_needs_reset()):
		position = _reset_position
		rotation = _reset_rotation

	# see what we ran into, gobble it if we can
	if collision:
		print("player collision with: ", collision.get_collider().name)
		if (collision.get_collider().has_method("gobbled")):
			collision.get_collider().gobbled()


func _on_light_up_timer_timeout():
	$Sprite2D.material.set_shader_parameter("override_set", false)


## trigger the "light up" effect to this color
func light_up(color: Color):
	$Sprite2D.material.set_shader_parameter("override_set", true)
	$Sprite2D.material.set_shader_parameter("override_color", color)
	$light_up_timer.start()


func _direction() -> float:
	var rv = 0
	if Input.is_action_pressed("ui_left"):
		rv = -1
	if Input.is_action_pressed("ui_right"):
		rv = 1
	return rv


func _velocity() -> Vector2:
	var rv = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		rv = Vector2.UP.rotated(rotation)
	return rv


func _needs_reset() -> bool:
	return Input.is_action_pressed("ui_accept")
