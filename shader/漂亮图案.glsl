// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
float random(vec2 st){
return fract(sin(dot(st.xy,vec2(12.453,78.4131)))*43758.34242323);
}
vec2 truchetPattern(vec2 st,float index){
    index=fract(((index-0.5)*2.0));
    if(index>0.75){
        st=vec2(1.0)-st;
    }else if(index>0.5){
        st=vec2(1.0-st.x,st.y);
    }else if(index>0.25){
        st=1.0-vec2(1.0-st.x,st.y);
    }

    return st;
}
float smooth(vec2 st){
    return smoothstep(st.x-0.3,st.x,st.y)-
        smoothstep(st.x,st.x+0.3,st.y);
}
float circle(vec2 st){
    return step(length(st),0.6)-step(length(st),0.2)+
        (step(length(st-vec2(1.0)),0.6)-
        step(length(st-vec2(1.0)),0.4)
        );
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st*=10.0;
    st=(st-vec2(5.0))*(abs(sin(u_time*0.01))*10.0);
    st.x+=u_time*3.0;
	vec2 ipos=floor(st);
    vec2 fpos=fract(st);
    vec2 tile=truchetPattern(fpos,random(ipos));
    
    vec3 color = vec3(step(tile.x,tile.y));
   
   // color = vec3(st.x,st.y,abs(sin(u_time)));

    gl_FragColor = vec4(color,1.0);
}