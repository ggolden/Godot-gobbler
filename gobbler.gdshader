shader_type canvas_item;

uniform vec4 override_color = vec4(1, 0, 0, 1.0);
uniform bool override_set = false;
uniform bool bottom_set = false;
uniform bool left_set = false;
uniform bool right_set = false;

void fragment() {
	if (override_set) {
		vec4 replacement = vec4(override_color.r, override_color.g, override_color.b, COLOR.a);
		if ((UV.x < 0.05) || (UV.x > 0.95) || (UV.y < 0.05) || (UV.y > 0.95)) {
			COLOR = replacement;
		} else if (COLOR.r > 0.4) {
			COLOR = replacement;
		}
	}
	
	if (bottom_set) {
		vec4 replacement = vec4(1, 0, 0, COLOR.a);
		if (UV.y > 0.95) {
			COLOR = replacement;
		}
	}
	
	if (left_set) {
		vec4 replacement = vec4(0, 1, 0, COLOR.a);
		if (UV.x < 0.05) {
			COLOR = replacement;
		}
	}
	
	if (right_set) {
		vec4 replacement = vec4(0, 0, 1, COLOR.a);
		if (UV.x > 0.95) {
			COLOR = replacement;
		}
	}
}
