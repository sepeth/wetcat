shader_type canvas_item;

uniform float time_factor = 2.0;
uniform vec2 amplitude = vec2(0.0, 8.0);
uniform vec2 pull_factor = vec2(0.0, 0.5);

void vertex() {
	VERTEX.y += sin(TIME*time_factor + VERTEX.y * pull_factor.y) * amplitude.y;
}
