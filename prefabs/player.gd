extends Entity

@export var bullet : PackedScene

@export var spawn_flip : bool = false
@export var color_switch : bool = false

@export var die_sound : AudioStreamWAV
@export var respawn_sound : AudioStreamWAV
@export var jump_sound : AudioStreamWAV
@export var shoot_sound : AudioStreamWAV

@onready var sound = get_node("Sound")
@onready var gun_point = get_node("GunPoint")
@onready var camera = get_node_or_null("Camera2D")

var spawn_position : Vector2

var can_respawn : bool = false
var can_die : bool = true
var can_flip : bool = true

var can_dash : bool = false

func die(time : float) -> void:
	sound.stream = die_sound
	sound.play()
	_dead = true
	await get_tree().create_timer(time).timeout
	can_dash = false
	can_respawn = true
	
func respawn() -> void:
	can_respawn = false

	can_die = false
	sound.pitch_scale = 1.0
	sound.stream = respawn_sound
	sound.play()
	
	can_flip = false
	
	_sprite.play_backwards("die")
	global_position = spawn_position
	_flip = spawn_flip
	
	await get_tree().create_timer(.5).timeout
	_dead = false
	can_flip = true
	await get_tree().create_timer(.5).timeout
	can_die = true

func shoot(scene : PackedScene):
	var e = scene.instantiate()
	get_node("..").add_child.call_deferred(e)
	sound.stream = shoot_sound
	sound.pitch_scale = randf_range(0.8, 1.8)
	sound.play()
	e.add_to_group("Player")
	e.global_position = gun_point.global_position
	e._direction = _dash_direction

func _ready():
	spawn_position = global_position
	_flip = spawn_flip
	
func _physics_process(delta : float) -> void:
	
	_sprite.use_parent_material = not color_switch
	gun_point.position.x = 4 * _dash_direction
	if not _dead:
		
		can_respawn = false

		_direction = Input.get_axis("ui_left", "ui_right")
		_entity_process(delta)
		
		if Input.is_action_just_pressed("shoot"):
			shoot(bullet)
		
		if can_flip:
			if Input.is_action_just_pressed("switch"):
				sound.stream = jump_sound
				_flip = not _flip
				sound.play()
				sound.pitch_scale = 1.0 + (float(not _flip) / 2.0)
		
		if is_on_floor():
			can_dash = true
			can_flip = true
			if _direction: 
				_sprite.play("run")
			else: _sprite.play("idle")
		else:
			_sprite.play("air")
			can_flip = false
	else:
		if can_respawn and Input.is_action_just_pressed("ui_accept"):
			respawn()

func query_area_entered(area):
	if area.is_in_group("Room") and camera != null:
		var hitbox = area.get_node("Hitbox")
		var size = hitbox.shape.extents*2.0
		
		camera.limit_top = hitbox.global_position.y - size.y/2.0
		camera.limit_left = hitbox.global_position.x - size.x/2.0
		
		camera.limit_bottom = camera.limit_top + size.y
		camera.limit_right = camera.limit_left + size.x
	if area.is_in_group("ColorSwitch"):
		color_switch = true

	if area.is_in_group("CanFlip"):
		can_flip = false
	
func hazard_query_body_entered(body):
	if body.is_in_group("Hazard") or body.is_in_group("Bullet") and not body.is_in_group("Player"):
		if can_die:
			sound.pitch_scale = 1.0
			_sprite.play("die")
			die(.5)

func query_area_exited(area):
	if area.is_in_group("ColorSwitch"):
		color_switch = false
	if area.is_in_group("CanFlip"):
		can_flip = true

