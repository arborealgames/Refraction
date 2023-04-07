extends Entity

var color_switch : bool = false

@onready var sprite = $Sprite
@onready var trail = $Trail

func _physics_process(delta):
	_entity_process(delta)
	if color_switch:
		modulate = Color.BLACK
	else:
		modulate = Color.WHITE
	if sprite.frame == 5:
		queue_free()
func hitbox_body_entered(body):
	if not body.is_in_group("Player"):
		sprite.play("default")
		trail.emitting = false
		_direction = 0
		_grav = 0
	
func hitbox_area_entered(area):
	if area.is_in_group("ColorSwitch"):
		color_switch = true
		
func hitbox_area_exited(area):
	if area.is_in_group("ColorSwitch"):
		color_switch = false
		
