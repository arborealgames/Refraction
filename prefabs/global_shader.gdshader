shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float precision : hint_range(0, 1, 0.05);

uniform vec4 color_0 : source_color;
uniform vec4 color_1 : source_color;
uniform vec4 color_2 : source_color;
uniform vec4 color_3 : source_color;
uniform vec4 color_4 : source_color;
uniform vec4 color_5 : source_color;
uniform vec4 color_6 : source_color;
uniform vec4 color_7 : source_color;
uniform vec4 color_8 : source_color;
uniform vec4 color_9 : source_color;

uniform vec4 replace_0 : source_color;
uniform vec4 replace_1 : source_color;
uniform vec4 replace_2 : source_color;
uniform vec4 replace_3 : source_color;
uniform vec4 replace_4 : source_color;
uniform vec4 replace_5 : source_color;
uniform vec4 replace_6 : source_color;
uniform vec4 replace_7 : source_color;
uniform vec4 replace_8 : source_color;
uniform vec4 replace_9 : source_color;

vec4 swap_color(vec4 color){
	vec4 original_colors[10] = vec4[10] (color_0, color_1, color_2, color_3, color_4, color_5, color_6, color_7, color_8, color_9);
	vec4 replace_colors[10] = vec4[10] (replace_0, replace_1, replace_2, replace_3, replace_4, replace_5, replace_6, replace_7, replace_8, replace_9);
	for (int i = 0; i < 10; i++) {
		if (distance(color, original_colors[i]) <= precision){
			return replace_colors[i];
		}
	}
	return color;
}
void fragment() {
	COLOR = swap_color(textureLod(screen_texture, SCREEN_UV, 0.0));
}