extends Node2D

export var star: PackedScene
export var star_number: int = 100

var _rand = RandomNumberGenerator.new()

func _ready():
	_rand.randomize()
	var viewport_size = get_viewport_rect().size
	
	for _i in range(star_number):
		var oneStar = star.instance()
		oneStar.position = Vector2(_rand.randf_range(0.0, viewport_size.x),
				_rand.randf_range(0.0, viewport_size.y))
		oneStar.rotation = _rand.randf_range(0.0, 2 * PI)
		var star_scale = _rand.randf_range(0.25, 1.0)
		oneStar.scale = Vector2(star_scale, star_scale)
		add_child(oneStar)
