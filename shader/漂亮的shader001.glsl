// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
    vec2 pos=vec2(0.5)-st;
    float r=length(pos)*5.0;
    float a=atan(pos.y,pos.x);
    float f=abs(cos(a*5.0));
   // f=smoothstep(-0.5,1.0,cos(a*10.0+u_time))*0.2+0.;
	f=abs(cos(a*5.0+u_time)*sin(a*10.0+u_time)*1.9+0.2);
    vec3 color = vec3(0.);
    float rr=1.0-(smoothstep(f,f+0.02,r));
    color = vec3(rr);

    gl_FragColor = vec4(color,1.0);
}