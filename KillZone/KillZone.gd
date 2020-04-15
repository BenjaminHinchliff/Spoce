extends Area2D

func _on_KillZone_body_entered(body: Node) -> void:
	if body is Ship:
		(body as Ship).kill()
