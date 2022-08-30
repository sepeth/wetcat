shader_type canvas_item;

void vertex() {
	VERTEX += cos(TIME*2.0) * vec2(0.0, 8.0);
}