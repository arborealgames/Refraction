extends Node

var game_paused : bool = false
var load_ready : bool = false

@onready var level_view = get_node("Level")
@onready var transition = get_node("Transition")
@onready var prism_load = get_node("PrismLoad")

@onready var current_level = level_view.get_child(0)

func change_level(level : PackedScene):
	prism_load.show()
	load_ready = false
	transition.stop()
	transition.play("b")
	await get_tree().create_timer(.5).timeout
	var old_level = level_view.get_child(0)
	var new_level = level.instantiate()
	await get_tree().create_timer(.5).timeout
	old_level.queue_free()
	level_view.add_child.call_deferred(new_level)
	load_ready = true
	if load_ready:
		await get_tree().create_timer(.5).timeout
		transition.play("a")
		prism_load.hide()
		#current_level = new_level
		print("Switched to ", new_level.name, " ( ", new_level.get_child_count(), " )")
		return 0

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		game_paused = not game_paused
	if Input.is_action_just_released("debug_0"):
		change_level(load("res://scenes/levels/tutorial.tscn"))
	elif Input.is_action_just_released("debug_1"):
		change_level(load("res://scenes/levels/test.tscn"))
	
#	if game_paused:
#		current_level.process_mode = Node.PROCESS_MODE_PAUSABLE
#	else:
#		current_level.process_mode = Node.PROCESS_MODE_ALWAYS
