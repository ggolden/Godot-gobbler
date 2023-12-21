class_name Gobbler
extends CharacterBody2D
## Gobbler (player) controller


enum MovementType {ThreeWay, EightWway, Asteriods, WatchMouse, ToMouse}


## player control turn rate in radians / second
@export var turn_rate = PI
## player control advance speed in units / second
@export var advance_rate = 222
## player control method: "3way" for turn and advance, "8way" for full directional slid
@export var movement_type: MovementType = MovementType.ThreeWay


var _reset_position = Vector2.ZERO
var _reset_rotation = 0
var _target = Vector2.ZERO

func _ready():
	_reset_position = position
	_reset_rotation = rotation


func _physics_process(delta):
	match movement_type:
		MovementType.ThreeWay:
			_physics_process_3way(delta)
		MovementType.EightWway:
			_physics_process_8way(delta)
		MovementType.Asteriods:
			_physics_process_asteriods(delta)
		MovementType.WatchMouse:
			_physics_process_watch_mouse(delta)
		MovementType.ToMouse:
			_physics_process_to_mouse(delta)


func _on_light_up_timer_timeout():
	$Sprite2D.material.set_shader_parameter("override_set", false)


# in support of ToMouse movement
func _input(event):
	if event is InputEventMouseButton:
		_target = get_global_mouse_position()


## trigger the "light up" effect to this color
func light_up(color: Color):
	$Sprite2D.material.set_shader_parameter("override_set", true)
	$Sprite2D.material.set_shader_parameter("override_color", color)
	$light_up_timer.start()


func _physics_process_3way(delta):
	# turn based on player input
	var dir = 0
	if Input.is_action_pressed("ui_left"):
		dir = -1
	if Input.is_action_pressed("ui_right"):
		dir = 1
	rotation += dir * turn_rate * delta

	var vel = Vector2.ZERO
	if Input.is_action_pressed("ui_up"):
		vel = Vector2.UP.rotated(rotation)

	# advance based on player input
	var collision = move_and_collide(vel * advance_rate * delta)
	_handle_collision(collision)

	_handle_reset()


func _physics_process_8way(delta):
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = dir * advance_rate
	move_and_slide()
	_handle_collision(get_last_slide_collision())
	_handle_reset()


func _physics_process_asteriods(delta):
	var rotation_dir = Input.get_axis("ui_left", "ui_right")
	velocity = transform.y * Input.get_axis("ui_up", "ui_down") * advance_rate
	rotation += rotation_dir * turn_rate * delta
	move_and_slide()
	_handle_collision(get_last_slide_collision())
	_handle_reset()


func _physics_process_watch_mouse(delta):
	look_at(get_global_mouse_position())
	# look_at "points" the x+, but our "forward" is y+... so rotate
	rotate(PI/2)
	velocity = transform.y * Input.get_axis("ui_up", "ui_down") * advance_rate
	move_and_slide()
	_handle_collision(get_last_slide_collision())
	_handle_reset()


func _physics_process_to_mouse(delta):
	velocity = position.direction_to(_target) * advance_rate

	if _target != Vector2.ZERO:
		look_at(_target)
		# look_at "points" the x+, but our "forward" is y+... so rotate
		rotate(PI/2)

	# avoid jitter when very close
	var collision = null
	if _target != Vector2.ZERO and position.distance_to(_target) > 10:
		move_and_slide()
		collision = get_last_slide_collision()
	else:
		collision = move_and_collide(Vector2.ZERO)
	_handle_collision(collision)

	_handle_reset()


func _handle_collision(collision):
	# see what we ran into, gobble it if we can
	if collision:
		print("player collision with: ", collision.get_collider().name)
		if (collision.get_collider().has_method("gobbled")):
			collision.get_collider().gobbled()


func _handle_reset():
	if (Input.is_action_pressed("ui_accept")):
		position = _reset_position
		rotation = _reset_rotation
