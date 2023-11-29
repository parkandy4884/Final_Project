shader_type canvas_item;

float square(in vec2 p, in float s) {
    vec2 d = abs(p) - s;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

void fragment() {
    vec2 iResolution = (1.0 / SCREEN_PIXEL_SIZE);
    vec2 uv = (FRAGCOORD.xy * 2.0 - iResolution.xy) / iResolution.y;
    vec2 uv0 = uv;
    uv *= 0.75;

    vec3 col = vec3(1.0, 0.0, 0.0); // Red color

    for (float i = 1.0; i < 4.0; i++) {
        uv = fract(uv * 2.0) - 0.5;

        float d = square(uv, 75540.0);
        d *= length(uv0);
        d = cos(d * 8.0 - TIME * i * 2.5);
        d = abs(d);

        // Assign black instead of white
        col *= smoothstep(0.2, 0.5, d);
    }

    COLOR = vec4(col, 1.0);
}