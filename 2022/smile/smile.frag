// thanks to The Art of Code
// https://www.youtube.com/watch?v=GgGBR4z8C9o

float circle(vec2 uv, vec2 p, float r, float blur)
{
    float d = length(uv - p);
    float c = smoothstep(r, r - blur, d);
    
    return c;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord.xy / iResolution.xy;
    
    // remaping to a new range (from -.5 to .5) -> (0, 0) in the middle of the screen
    uv -= .5;
    // fixing the aspect ratio distortion
    uv.x *= iResolution.x / iResolution.y;
    
    float r = .4;
    
    float mask = circle(uv, vec2(0.), r, .01);
    // left eye
    mask -= circle(uv, vec2(-.15, .1), .07, .01);
    // right eye
    mask -= circle(uv, vec2(.15, .1), .07, .01);
    
    // two overlapping circles
    float mouth = circle(uv, vec2(0.), .3, .01);
    mouth -= circle(uv, vec2(0., .1), .3, .01);
    
    mask -= clamp(mouth, 0., 1.);
    
    vec3 col = vec3(1., 1., 0.) * mask;
    
    // output to screen
    fragColor = vec4(col, 1.0);
}