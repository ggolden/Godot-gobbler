class_name UI
extends Control
## The UI for the game


func _ready():
	$ScoreBar.reset()
	show_score(0)
	show_fuel(0)


## display this score
func show_score(score):
	$PlayerScore.text = str(score)
	$ScoreBar.set_level(score)


## display this fuel level
func show_fuel(fuel):
	$FuelBar.set_level(fuel)
