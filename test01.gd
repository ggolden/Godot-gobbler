extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const PUSH_FORCE = 4000.0
const turn_rate = PI

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# print(str(velocity))
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	if Input.is_action_pressed("ui_accept"):
		velocity = Vector2(0, JUMP_VELOCITY).rotated(rotation)
		#var force = Vector2.UP.rotated(rotation) * JUMP_VELOCITY * delta
		# print(str(velocity))
		#velocity -= force

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	# print(str(direction))
	if is_on_floor():
		# rotation = 0.0
		rotation = move_toward(rotation, 0, 3 * delta)
		print("floor " + str(rotation))
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		print("flying")
		rotation += direction * turn_rate * delta

	move_and_slide()
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_force(collision.get_normal() * -PUSH_FORCE)
