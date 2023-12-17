attribute vec4 a_Position;
uniform mat4 u_ModelView;
uniform mat4 u_ProjectView;
void main(){
    gl_Position=u_ProjectView*u_ModelView*a_Position;
    gl_PointSize=50.0;
}
