#define PI 3.1415926

float random(vec2 st){
   float sd=dot(st,vec2(12.90343,38.423));
   return fract(sin(sd)*43234.3432);
}

float noise(vec2 st){
    vec2 i=floor(st);
    vec2 f=fract(st);
    float a=random(i+vec2(0.0));
    float b=random(i+vec2(1.0,0.0));
    float c=random(i+vec2(0.0,1.0));
    float d=random(i+vec2(1.0,1.0));
     a=dot(a,f-vec2(0.0));
    b=dot(rb,f-vec2(1.0,0.0));
    c=dot(c,f-vec2(0.0,1.0));
    d=dot(d,f-vec2(1.0,1.0));
    

    vec2 u=f*f*(3.0-2.0*f);

    float am=mix(a,b,u.x)+(c-a)*(1.0-u.x)*u.y+(d-b)*u.y*u.x;

};

float lines(vec2 st,float f){
    st*=10.0;
    return smoothstep(0.0,f+f*0.5 ,abs(sin(st.x*PI)+f*2.0)*.5 );
}


float shape(vec2 st, float radius) {
	st = vec2(0.5)-st;
    float r = length(st)*2.0;
    float a = atan(st.y,st.x);
    float m = abs(mod(a+u_time*2.,3.14*2.)-3.14)/3.6;
    float f = radius;
    m += noise(st+u_time*0.1)*.5;
    a *= 1.+abs(atan(u_time*0.2))*.1;
    a *= 1.+noise(st+u_time*0.1)*0.1;
    f += sin(a*50.)*noise(st+u_time*.2)*.3;
    f += (sin(a*20.)*.1*pow(m,2.));
    return 1.-smoothstep(f,f+0.007,r);
}

float shapeBorder(vec2 st, float radius, float width) {
    return shape(st,radius)-shape(st,radius-width);
}