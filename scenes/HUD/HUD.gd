class_name HUD
extends Control

var p1_score: int setget set_p1_score, get_p1_score
var p2_score: int setget set_p2_score, get_p2_score

onready var p1_wins = $P1Wins as Label
onready var p2_wins = $P2Wins as Label
onready var tie = $Tie as Label

func _ready() -> void:
	set_p1_score(0)
	set_p1_score(0)

func set_p1_score(score: int) -> void:
	p1_score = score
	($P1Score as Label).text = p1_score as String
	
func get_p1_score() -> int:
	return p1_score

func set_p2_score(score: int) -> void:
	p2_score = score
	($P2Score as Label).text = p2_score as String
	
func get_p2_score():
	return p2_score
	
func p1_scored():
	set_p1_score(p1_score + 1)
	if p2_wins.visible:
		p2_wins.hide()
		tie.show()
	else:
		p1_wins.show()
	
func p2_scored():
	set_p2_score(p2_score + 1)
	if p1_wins.visible:
		p1_wins.hide()
		tie.show()
	else:
		p2_wins.show()
	
func restart():
	p1_wins.hide()
	p2_wins.hide()
	tie.hide()
