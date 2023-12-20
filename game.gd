class_name Game
extends Node
## Game controller


## player's score
var player_score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$GobbleSpawner.gobble_was_gobbled.connect(_gobble_was_gobbled)


func _gobble_was_gobbled(value: int, color: Color):
	player_score += value
	$UI.show_score(player_score)
	$Gobbler.light_up(color)
