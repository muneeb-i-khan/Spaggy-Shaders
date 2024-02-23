#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 palette(float t){
    vec3 a=vec3(.5,.5,.5);
    vec3 b=vec3(.5,.5,.5);
    vec3 c=vec3(1.,1.,1.);
    vec3 d=vec3(0.,.33,.66);
    
    return a+b*cos(6.28318*(c*t+d));
}

vec2 rotate(vec2 p,float angle){
    float s=sin(angle);
    float c=cos(angle);
    return vec2(p.x*c-p.y*s,p.x*s+p.y*c);
}

vec2 rotate90(vec2 p){
    return vec2(-p.y,p.x);
}

void main(){
    vec2 uv=(gl_FragCoord.xy*2.-u_resolution.xy)/u_resolution.y;
    vec2 uv0=uv;
    vec3 finalColor=vec3(0.);
    
    for(float i=0.;i<6.;i++){
        uv=fract(uv*1.5)-.5;
        
        float d=length(uv)*exp(-length(uv0));
        
        vec3 col=palette(length(uv0)+i*.2+u_time*.4);
        
        d=sin(d*20.+u_time)/8.;
        d=abs(d);
        
        d=pow(.01/d,1.2);
        
        finalColor+=col*d;
        
        uv=rotate(uv,3.14159/3.);
        uv=rotate90(uv);
    }
    
//   if (length(uv0) < 0.3) {

//     float m = length(uv0) * 10.0;
//     finalColor = vec3(0.0, 0.0, 0.0) * sin(m + u_time);
// }
    
    gl_FragColor=vec4(finalColor,1.);
}
