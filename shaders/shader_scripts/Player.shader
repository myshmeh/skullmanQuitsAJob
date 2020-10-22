shader_type canvas_item;
uniform bool active = false;

float randi(vec2 coord) {
	return fract(sin(dot(coord, vec2(50.0, 50.0))) * 0.0001);
}

void fragment(){
	COLOR = texture(TEXTURE, UV);
	if (active) {
		vec2 offset = vec2(TIME * 0.5, TIME * 0.5);
		COLOR = vec4(COLOR.rgb, COLOR.a * randi(UV + offset));
	}
}