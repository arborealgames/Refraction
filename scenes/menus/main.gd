extends Node


var selected_id : float = 0.0

@onready var button_icon = $Origin/Icon
@onready var origin = $Origin
@onready var start_button = $Origin/StartButton
@onready var option_button = $Origin/OptionButton
@onready var extras_button = $Origin/ExtrasButton
@onready var exit_button = $Origin/ExitButton
var button_hovered : bool = false

func _process(_delta):
	
	button_hovered = start_button.is_hovered() or option_button.is_hovered() or extras_button.is_hovered()

	if start_button.is_hovered():
		button_icon.modulate = Color.YELLOW
		selected_id = 0.0
		button_icon.frame = 0
		if Input.is_action_just_pressed("click") or Input.is_action_just_pressed("ui_accept"):
			get_tree().change_scene_to_file("res://scenes/game.tscn")
	elif option_button.is_hovered():
		button_icon.modulate = Color.YELLOW
		selected_id = 1.0
		button_icon.position.y = 15.0
		button_icon.frame = 1
	elif extras_button.is_hovered():
		button_icon.modulate = Color.YELLOW
		selected_id = 2.0
		button_icon.position.y = 30.0
		button_icon.frame = 2
	elif exit_button.is_hovered():
		button_icon.modulate = Color.WHITE
		selected_id = 3.0
		button_icon.position.y = 45.0
		button_icon.frame = 3
		if Input.is_action_just_pressed("click") or Input.is_action_just_pressed("ui_accept"):
			get_tree().quit()
	else:
		button_icon.modulate = Color.WHITE
		selected_id = -1.0
