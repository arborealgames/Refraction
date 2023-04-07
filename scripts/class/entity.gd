extends CharacterBody2D
class_name Entity

@onready var _sprite = get_node("Sprite")
@warning_ignore("unused_private_class_variable")
@onready var _hitbox = get_node("Hitbox")

@export var _speed : float = 160
@export var _friction : float = .25
@warning_ignore("unused_private_class_variable")
@export var _grav : float = 250

@export var _flip : bool = false
@export var _direction : float = 0

@warning_ignore("unused_private_class_variable")
var _dead : bool = false
var _dash_direction : float = 1.0

func _entity_process(_delta : float) -> void:
	_sprite.flip_v = _flip
	up_direction = Vector2(0, arboreal.conv_bool(_flip))
	velocity.x = lerp(velocity.x, _direction * _speed, _friction)
	if not is_on_floor():
		velocity.y = _grav * arboreal.conv_bool(not _flip)
	
	if _direction: 
		_sprite.flip_h = velocity.x < 0
		_dash_direction = _direction
	else: velocity.x = move_toward(velocity.x, .0, _friction) 
	move_and_slide()
