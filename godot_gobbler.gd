extends Node2D

var gobble = load("res://gobble.tscn")
var gobble_sequence = 1

func _ready():
	$game_controller.score_changed.connect(score_changed)
	
func score_changed(old, new):
	print("score changed: " + str(old) + " -> " + str(new))
	
func take_value(value: int, color: Color):
	print("taking value: " + str(value) + " color: " + str(color))
	$game_controller.increment_score(value)
	$godot_player.light_up(color)

func new_gobble():
	var window_size = DisplayServer.window_get_size()

	var location = Vector2(randi_range(10, window_size.x-20), randi_range(10, window_size.y-20) * -1)
	var color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
	var value: int = int(color.r + color.b + color.g) + 1
	var known_as = "gobble " + str(gobble_sequence)
	gobble_sequence += 1

	var instance = gobble.instantiate()
	instance.name = known_as
	instance.position = location
	instance.color = color
	instance.value = value

	instance.value_available.connect(take_value)

	add_child(instance)
	print("new gobble: " + instance.name + " @ " + str(instance.position) + " value: " + str(value))

func _on_timer_timeout():
	new_gobble()
