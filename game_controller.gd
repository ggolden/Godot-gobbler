extends Node2D

signal score_changed(old, new)

var score = 0

func display_score():
	get_node("score").text = str(score)

func increment_score(by):
	var old_score = score
	score += by
	display_score()
	score_changed.emit(old_score, score)

func _ready():
	display_score()
