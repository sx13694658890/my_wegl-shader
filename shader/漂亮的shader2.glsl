// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif
#define PI 3.14159265358979323846
uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
float circle(vec2 st,float l){
    vec2 ll= st-vec2(0.5);
    return 1.0-smoothstep(l-(l*0.01),l+(l*0.01),
                          dot(ll,ll)*10.0);
}
vec2 tile(vec2 st,float zoom){
    st*=zoom;
    return fract(st);
}
vec2 rotate2D(vec2 st,in float angle){
    st-=0.5;
    st=mat2(cos(angle),-sin(angle),sin(angle),cos(angle))*st;
    st+=0.5;
    return st;
}
float box(vec2 st, vec2 size, float smoothEdges){
    size=vec2(0.5)-size*0.5;
    vec2 aa=vec2(smoothEdges*1.0);
    vec2 uv=smoothstep(size,size+aa,st);
    uv*=smoothstep(size,size+aa,1.0-st);
    return uv.x*uv.y;
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st=tile(st,4.0);
    st=rotate2D(st,PI+u_time);
    vec3 color=vec3(box(st,vec2(0.72),0.01));
    gl_FragColor = vec4(color,1.0);
}