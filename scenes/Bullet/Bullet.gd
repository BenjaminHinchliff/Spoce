class_name Bullet
extends RigidBody2D

func _on_Bullet_body_entered(body: Node) -> void:
	if body is Ship:
		(body as Ship).kill()
	queue_free()


func _on_LifetimeTimer_timeout() -> void:
	queue_free()
