shader_type canvas_item;

uniform vec4 mod_color;
uniform float remaining;
uniform vec2 resolution;

float random(float x) {
	return fract(sin(x)*100000.0);
}

float twod_random (in vec2 _st) {
    return fract(sin(dot(_st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec2 st = mod(UV.xy + vec2(0,TIME) / 5.0, 1) * resolution.xy;
	
	if(1.0 - remaining > UV.y) {
		COLOR = mod_color;
		COLOR.w = twod_random(floor(st));
	}
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
