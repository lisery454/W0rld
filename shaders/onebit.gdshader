shader_type canvas_item;

uniform vec2 size = vec2(1, 1);
uniform float threshold = 0.5;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

vec4 to_one_bit(vec4 color) {
	float sum = (color.r * 0.299 + color.g * 0.587 + color.b * 0.114);
	float f = ceil(sum - threshold);
	color = mix(vec4(0.2,0.2,0.2,1), vec4(0.8,0.8,0.8,1), f);
	return color;
}

vec2 get_new_uv(vec2 uv, vec2 screen_pixel_size) {
	vec2 size_uv = screen_pixel_size * size;
	vec2 new_uv = floor(uv / size_uv) * size_uv;
	return new_uv;
}

void fragment() {
		vec2 new_uv = get_new_uv(SCREEN_UV, SCREEN_PIXEL_SIZE);
		vec4 color = textureLod(screen_texture, new_uv, 0.0);
		COLOR = to_one_bit(color);
}