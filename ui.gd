class_name UI
extends Control
## The UI for the game


func _ready():
	$ScoreBar.reset()
	show_score(0)


## display this score
func show_score(score):
	$PlayerScore.text = str(score)
	$ScoreBar.set_level(score)
