// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
vec2 tile(vec2 st,float num){
    st*=num;
    return st;
}
float random(vec2 st){
    return fract(sin(dot(st,vec2(12.9898,78.233)))*
        43758.5453123);
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st=tile(st,30.0);
    vec2  ipos=floor(st);
    vec2 fpos=fract(st);
    
    vec3 color = vec3(random(ipos));
    //color = vec3(st.x,st.y,abs(sin(u_time)));

    gl_FragColor = vec4(color,1.0);
}