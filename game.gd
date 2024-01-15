class_name Game
extends Node
## Game controller


## amount of score needed for granting a single second of fuel
const FUEL_COST = 5


## starging fuel (in seconds)
@export var starting_fuel = 10.0


## player's score
var _player_score: int = 0

## player will get more fule at this score
var _next_fuel_award_score = FUEL_COST

@onready var _ui = $HUD/UI


# Called when the node enters the scene tree for the first time.
func _ready():
	$GobbleSpawner.gobble_was_gobbled.connect(_gobble_was_gobbled)
	$Gobbler.fuel_level_changed.connect(
		func (value: float): _ui.show_fuel(value)
	)
	$Gobbler.add_fuel(starting_fuel)


func _gobble_was_gobbled(value: int, color: Color):
	_player_score += value
	_ui.show_score(_player_score)
	$Gobbler.light_up(color)
	
	if _player_score >= _next_fuel_award_score:
		$Gobbler.add_fuel(1)
		_next_fuel_award_score += FUEL_COST
