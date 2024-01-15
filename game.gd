class_name Game
extends Node
## Game controller


## amount of score per fuel grant
const FULE_COST = 5

## player's score
var _player_score: int = 0

## player will get more fule at this score
var _next_fuel_award_score = FULE_COST


# Called when the node enters the scene tree for the first time.
func _ready():
	$GobbleSpawner.gobble_was_gobbled.connect(_gobble_was_gobbled)
	$Gobbler.fuel_level_changed.connect(
		func (value: float): $UI.show_fuel(value)
	)


func _gobble_was_gobbled(value: int, color: Color):
	_player_score += value
	$UI.show_score(_player_score)
	$Gobbler.light_up(color)
	
	if _player_score >= _next_fuel_award_score:
		$Gobbler.add_fuel(1)
		_next_fuel_award_score += FULE_COST
