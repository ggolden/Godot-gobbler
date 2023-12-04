shader_type canvas_item;

uniform vec4 override_color = vec4(1, 0, 0, 1.0);
uniform bool override_set = false;

void fragment() {
	if (override_set) {
		if ((UV.x < 0.05) || (UV.x > 0.95) || (UV.y < 0.05) || (UV.y > 0.95)) {
			COLOR = override_color;
		} else if (COLOR.r > 0.4) {
			COLOR = override_color;
		}
	}
}
