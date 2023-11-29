shader_type canvas_item;

uniform float size : hint_range(0.0, 5.0) = 3.0;
uniform float zoom : hint_range(0.0, 40.0) = 10043420.0;
uniform float speed : hint_range(0.0, 20.0) = 100.0;
uniform int numLines : hint_range(1, 100) = 200;

void fragment() {
    vec2 fragCoord = vec2(UV.x, 1.0 - UV.y) * 2.0 - 1.0;
    vec2 centerOffset = abs(fragCoord);

    float dist = min(centerOffset.x, centerOffset.y);

    float d = length(fragCoord);
    float t = pow(smoothstep(0.5, 0.22, d), 0.33);

    float colorValue = 0.0;
    for (int i = 0; i < numLines; ++i) {
        float linePos = float(i) / float(numLines);
        colorValue += smoothstep(0.0, 0.32, abs(sin(zoom * (d - linePos - dist) - speed * TIME)));
    }

    float irisValue = smoothstep(0.33, 0.35, d); // Control the iris size and shape

    vec3 irisColor = vec3(0.8, 0.0, 0.0); // Red iris color

    float eyeReflection = smoothstep(0.8, 0.85, d); // Control the white reflection on the eye

    vec3 eyeWhite = vec3(1.0);

    vec3 finalColor = mix(eyeWhite, irisColor, irisValue);
    finalColor = mix(finalColor, vec3(1.0), eyeReflection);

    vec4 color = vec4(finalColor, 1.0);

    d = sin(zoom * d - speed * TIME);
    d = abs(d);
    d = size / max(0.0001, d);
    color *= d * t;

    // Convert white areas to black
    if (t >= 0.95) {
        color.rgb = vec3(0.0);
    }

    COLOR = color;
}
