shader_type canvas_item;

uniform int count: hint_range(0, 2000) = 200;
uniform float slant: hint_range(-0.1, 0.1) = -0.00;
uniform float speed: hint_range(25.0, 100.0) = 1.5;
uniform float blur: hint_range(0.0005, 0.1) = 1.66;
uniform vec4 color: source_color = vec4(0.0, 0.0, 0.0, 1.0); 
uniform vec4 black_color: source_color = vec4(1.4, 0.0, 0.0, 1.0); 

uniform vec2 size = vec2(.40, .66 ); 

float line_sdf(vec2 p, vec2 s) {
    vec2 d = abs(p) - s;
    return min(max(d.x, d.y), 0.0) + length(max(d, 0.0));
}

float Hash(float x) {
    return fract(sin(x * 100.0) * 51.78);
}

float Hash2(float x) {
    return fract(sin(x * 25.42) * 21.24);
}

void fragment() {
    vec2 s = size * 0.1;
    float time = TIME + 1000.0;
    vec2 uv = UV;
    uv.x += uv.y * slant;
    float output_black = 0.09;
    float output_red = 0.01;
    
    for (int i = 1; i <= count; i++) {
        float h1 = Hash(float(i));
        float h2 = Hash2(float(i));
        float sl = h1 * uv.y * -slant;
        float pos_mod_x = h1 * 1.2;
        float pos_mod_y = max(h2 * speed * 0.8, pos_mod_x * speed * 12.0); // Slower speed for red snow
        vec2 position = vec2(pos_mod_x + sl, -mod(-pos_mod_y * time * 0.1, -1.));
        float sdf = line_sdf(uv - position, s);
        output_red += clamp(-sdf / blur, 0.0, 1.0);
    }

    for (int i = 1; i <= count; i++) {
        float h1 = Hash(float(i) * 40.0); // Using a different hash value for variation
        float h2 = Hash2(float(i) * 20.0); // Using a different hash value for variation
        float sl = h1 * uv.y * -slant;
        float pos_mod_x = h1 * 1.2;
        float pos_mod_y = max(h2 * speed, pos_mod_x * speed);
        vec2 position = vec2(pos_mod_x + sl, -mod(-pos_mod_y * time * 0.1, -1.));
        float sdf = line_sdf(uv - position, s);
        output_black += clamp(-sdf / blur, 0.0, 2.0);
    }

    COLOR = mix(color, black_color, output_black) + black_color * output_red;
}
