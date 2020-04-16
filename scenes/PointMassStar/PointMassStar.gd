extends Area2D

onready var collision_shape := $CollisionShape2D as CollisionShape2D

func _ready() -> void:
	var viewport_size = get_viewport_rect().size
	position = viewport_size / 2.0
	(collision_shape.shape as RectangleShape2D).extents = viewport_size / 2.0


func _on_StarKillZone_body_entered(body: Node) -> void:
	if body is Ship:
		(body as Ship).kill()
