itle:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;
vec2 random2( vec2 p ) {
    return fract(sin(vec2(
        dot(p,vec2(127.1,311.7)),
        dot(p,vec2(269.5,183.3))))*43758.5453);
}
float noise(vec2 st){
    st*=3.;
    vec2 ipos=floor(st);
    vec2 fpop=fract(st);
    vec2 point=random2(ipos);
    vec2 diff=point-fpop;
    return length(diff);
}
void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
   // st=fract(st*2.);
    st *= 13.;
   vec3 color = vec3(.0);
    // Tile the space
    float m_dist = 1.;
    vec2 m_point;
    vec2 i_st = floor(st);
    vec2 f_st = fract(st);
//     for(int x=-1;x<=1;x++){
//         for(int y=-1;y<=1;y++){
//             vec2 neighbor = vec2(float(x),float(y));
//              vec2 point = random2(neighbor+i_st);
//              point=0.5+0.5*sin(u_time+6.2831*point);
//              float dist = length(neighbor+point - f_st);
//             m_dist=abs(sin(dot(m_dist,dist)));
//         }
// }
   for(int j=-1;j<=1;j++){
       for(int i=-1;i<=1;i++){
           vec2 neighbor=vec2(float(i),float(j));
           vec2 point=random2(i_st+neighbor);
           point=0.5+0.5*sin(u_time+6.28*point);
           
           float dist=length(neighbor+point-f_st);
           if(dist<m_dist){
               m_dist=dist;
               m_point=point;
           }
       }
   }
 
   

    color+=dot(m_point,vec2(.3,.6));
    color-=abs(sin(20.*m_dist))*0.07;
    color+=1.-step(.05,m_dist);
    color.r+=step(.98,f_st.x)+step(.98,f_st.y);
    //color-=smoothstep(0.1,0.5,abs(sin(20.*m_dist)))*.5;
   // color = vec3(st.x,st.y,abs(sin(u_time)));

    gl_FragColor = vec4(color,1.0);
}