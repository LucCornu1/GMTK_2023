shader_type canvas_item;

uniform float dissolve_state : hint_range(0, 1) = 0.0;
uniform sampler2D dissolve_noise;

uniform float width : hint_range(0.0, 100.0);
uniform vec4 outline_color : source_color;

void fragment()
{
	vec4 texture_color = texture(TEXTURE, UV);
	
	// Colored outline
	float size = width / float(textureSize(TEXTURE, 0).x);
	float alpha = -8.0 * texture_color.a;
	alpha += texture(TEXTURE, UV + vec2(0.0, -size)).a;
	alpha += texture(TEXTURE, UV + vec2(size, -size)).a;
	alpha += texture(TEXTURE, UV + vec2(size, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(size, size)).a;
	alpha += texture(TEXTURE, UV + vec2(0.0, size)).a;
	alpha += texture(TEXTURE, UV + vec2(-size, size)).a;
	alpha += texture(TEXTURE, UV + vec2(-size, 0.0)).a;
	alpha += texture(TEXTURE, UV + vec2(-size, -size)).a;
	vec4 final_color = mix(texture_color, outline_color, clamp(alpha, 0.0, 1.0));
	COLOR = vec4(final_color.rgb, clamp(abs(alpha) + texture_color.a, 0.0, 1.0));

	// Dissolve
	float brightness = texture(dissolve_noise, UV).r;
	// COLOR = texture_color;
	COLOR.a *= step(dissolve_state, brightness);
}