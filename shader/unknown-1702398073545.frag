// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
float box(in vec2 _st, in vec2 _size){
    _size = vec2(0.5) - _size*0.5;
    vec2 uv = smoothstep(_size,
                        _size+vec2(0.001),
                        _st);
    uv *= smoothstep(_size,
                    _size+vec2(0.001),
                    1.0-_st);
    return uv.x*uv.y;
}

float cross(in vec2 _st, float _size){
    return  box(_st, vec2(_size,_size/6.)) +
            box(_st, vec2(_size/6.,_size));
}
mat2 rotate2d(float _angle){
    return mat2(cos(_angle),-sin(_angle),
                sin(_angle),cos(_angle));
}
mat2 scale(vec2 _scale){
    return mat2(_scale.x,0.0,
                0.0,_scale.y);
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
	
    st-=vec2(0.5)*0.4;
    st = scale( vec2(cos(u_time)+1.0) ) * st;
    st=rotate2d(abs(sin(u_time*PI)))*st;
    vec3 color = vec3(st.x,st.y,0.0);
    color += vec3(cross(st,0.55));

    gl_FragColor = vec4(color,1.0);
}