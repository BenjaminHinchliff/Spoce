extends Node

onready var hud = $HUD as HUD
onready var p1 = $P1 as Ship
onready var p2 = $P2 as Ship
onready var restart_timer = $RestartTimer as Timer

func _on_P1_died() -> void:
	hud.p2_scored()
	restart_timer.start()

func _on_P2_died() -> void:
	hud.p1_scored()
	restart_timer.start()

func _on_RestartTimer_timeout() -> void:
	p1.restart()
	p2.restart()
	hud.restart()
	var bullets = get_tree().get_nodes_in_group("bullets")
	for bullet in bullets:
		bullet.queue_free()
