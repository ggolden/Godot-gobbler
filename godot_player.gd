extends CharacterBody2D

# player control turn rate in radians / second
@export var turn_rate = PI

# player control advance speed in units / second
@export var advance_rate = 222

var reset_position = Vector2.ZERO
var reset_rotation = 0

func _ready():
	reset_position = position
	reset_rotation = rotation

func direction() -> float:
	var rv = 0
	if Input.is_action_pressed("ui_left"):
		rv = -1
	if Input.is_action_pressed("ui_right"):
		rv = 1
	return rv

func velocity() -> Vector2:
	var rv = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		rv = Vector2.UP.rotated(rotation)
	return rv

func needs_reset() -> bool:
	return Input.is_action_pressed("ui_accept")
	
func _physics_process(delta):
	# turn based on player input
	rotation += direction() * turn_rate * delta
	
	# advance based on player input
	var collision = move_and_collide(velocity() * advance_rate * delta)
	
	# handle reset
	if (needs_reset()):
		position = reset_position
		rotation = reset_rotation

	# see what we ran into, gobble it if we can
	if collision:
		print("player collision with: ", collision.get_collider().name)
		if (collision.get_collider().has_method("gobbled")):
			collision.get_collider().gobbled()
