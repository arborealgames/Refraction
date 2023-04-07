shader_type canvas_item;

uniform float height = 2.0;
uniform float height_frequency = 3.0;
uniform float height_offset = 0.0;

uniform float width = 0.0;
uniform float width_frequency = 0.0;
uniform float width_offset = 0.0;

void vertex() {
	VERTEX.y += height * sin((TIME * height_frequency) + height_offset);
	VERTEX.x += width * sin((TIME * width_frequency) + width_offset);
}
