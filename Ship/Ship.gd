class_name Ship
extends RigidBody2D

signal died

export var forward_force: float = 7.0
export var angular_torque: float = 10.0
export var starting_offset: Vector2 = Vector2(0.0, 0.0)
export var starting_velocity: Vector2 = Vector2(0.0, 0.0)
export(float, 0.0, 360.0) var starting_rotation: float
export var action_forward: String
export var action_left: String
export var action_right: String
export var action_fire: String
export var bullet_scene: PackedScene = load("res://Bullet/Bullet.tscn")
export var bullet_speed: float = 100.0
export var fire_cooldown: float = 0.25
export var colour: Color = Color(1.0, 1.0, 1.0)

var _alive := false
var _restarting := false
var _cooldown := fire_cooldown

onready var screen_size := get_viewport_rect().size
onready var flame := $Flame as CPUParticles2D
onready var sprite := $Sprite as Sprite
onready var collision_box := $CollisionShape2D as CollisionShape2D

func _ready() -> void:
	sprite.self_modulate = colour
	restart()
	
func _process(delta: float) -> void:
	_cooldown -= delta
	if _cooldown < 0.0 && Input.is_action_pressed(action_fire):
		_fire()
		_cooldown = fire_cooldown

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if _alive:
		_move_step(state)
		
	if _restarting:
		_restart(state)

func restart():
	_restarting = true

func kill(): 
	if (_alive):
		_alive = false
		sprite.visible = false
		flame.emitting = false
		collision_box.call_deferred("set_shape_disabled", true)
		($DeathExplosion as CPUParticles2D).emitting = true
		emit_signal("died")
		
func _restart(state: Physics2DDirectBodyState):
	var trans := state.transform
	trans = trans.rotated(-trans.get_rotation() + deg2rad(starting_rotation))
	var starting_position = screen_size / 2.0 + starting_offset
	position = starting_position
	trans.origin = starting_position
	state.transform = trans
	state.linear_velocity = starting_velocity
	state.angular_velocity = 0.0
	_alive = true
	sprite.visible = true
	collision_box.call_deferred("set_shape_disabled", false)
	_restarting = false

func _move_step(state: Physics2DDirectBodyState):
	if Input.is_action_pressed(action_forward):
		state.apply_central_impulse(
				Vector2(0.0, -forward_force).rotated(rotation))
		flame.emitting = true
	else:
		flame.emitting = false
	var torque := 0.0
	if Input.is_action_pressed(action_right):
		torque += angular_torque
	if Input.is_action_pressed(action_left):
		torque -= angular_torque
	state.apply_torque_impulse(torque)
	
	var trans := state.transform
	trans.origin.x = fposmod(trans.origin.x, screen_size.x)
	trans.origin.y = fposmod(trans.origin.y, screen_size.y)
	state.transform = trans
	
func _fire() -> void:
	var bullet = bullet_scene.instance()
	bullet.position = position + Vector2(0, -25).rotated(rotation)
	bullet.rotation = rotation
	bullet.linear_velocity = Vector2(0, -bullet_speed).rotated(rotation)
	get_tree().get_root().add_child(bullet)
