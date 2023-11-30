shader_type canvas_item;

uniform float distortion_factor : hint_range(0.0, 1.0) = 0.1;
uniform float speed_factor : hint_range(0.0, 10.0) = 1.0;
uniform float noise_factor : hint_range(0.0, 1.0) = 3.0;

void fragment() {
    // Get a random value between -1.0 and 1.0 for distortion
    float distortion = (fract(sin(dot(FRAGCOORD.xy, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * distortion_factor;

    // Calculate the time-based offset for noise
    float time_factor = sin(TIME * speed_factor);

    // Get a noise value
    float noise = (fract(sin(dot(FRAGCOORD.xy + time_factor, vec2(12.9898, 78.233))) * 43758.5453) - 0.5) * noise_factor;

    // Combine noise and distortion
    float combined = distortion + noise;

    // Apply the combined effect to the fragment color
    vec3 color = vec3(combined);
    COLOR = vec4(color, 1.0);
}