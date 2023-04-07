extends Node

var config = {
	graphics = {
		use_shader = true
	},
	window = {
		size = Vector3i(256, 144, 3),
		fullscreen = false,
		vsync = false,
	}
}

var debug : bool = false

func resize_window(new_size : Vector3i):
	get_window().size.x = new_size.x * new_size.z
	get_window().size.y = new_size.y * new_size.z
	get_window().position = DisplayServer.screen_get_size(0) / 2 - get_window().size / 2
	return new_size

func conv_bool(x : bool) -> float:
	if x == true:
		return 1.0
	else:
		return -1.0

func _ready() -> void:
	config.window_size = resize_window(config.window.size)
	
func _process(_delta):
	if Input.is_action_just_pressed("debug_toggle"):
		debug = not debug
	global_shader.visible = config.graphics.use_shader
	if debug:
		if Input.is_key_pressed(KEY_SPACE):
			config.graphics.use_shader = not config.graphics.use_shader
	if Input.is_action_just_pressed("fullscreen"):
		config.window.fullscreen = not config.window.fullscreen
		if not config.window.fullscreen:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
