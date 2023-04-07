extends Area2D

@export var scene : PackedScene
var can_go_through : bool = false
func _process(delta):
	if can_go_through:
		if Input.is_action_just_pressed("interact"):
			$"../../../..".change_level(scene)
func body_entered(body):
	if body.is_in_group("Player"):
		can_go_through = true
func body_exited(body):
	if body.is_in_group("Player"):
		can_go_through = false
