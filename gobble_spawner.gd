class_name GobbleSpawner
extends Node
## Spawns gobbles


## some gobble was gobbled
signal gobble_was_gobbled(value: int, color: Color)


## The gobble preset scene
var gobble_template = load("res://gobble.tscn")
## for a unique name of each gobble instance
var gobble_sequence = 1


func _on_spawn_timer_timeout():
	_spawn()


## Spawn a new gobble
func _spawn():
	var window_size = DisplayServer.window_get_size()

	var location = Vector2(randi_range(10, window_size.x-20), randi_range(10, window_size.y-20) * -1)
	var color = Color(randf_range(0, 1), randf_range(0, 1), randf_range(0, 1), 1)
	var known_as = "gobble " + str(gobble_sequence)
	gobble_sequence += 1

	var instance = gobble_template.instantiate()
	instance.name = known_as
	instance.position = location
	instance.color = color

	instance.was_gobbled.connect(_gobble_was_gobbled)

	add_child(instance)
	print("new gobble: " + instance.name + " @ " + str(instance.position) + " value: " + str(instance.value()))


func _gobble_was_gobbled(value: int, color: Color):
	gobble_was_gobbled.emit(value, color)
