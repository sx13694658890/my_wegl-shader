
var gl = null, projectMat4;
var VSHADER_SOURCE = '';
var FSHADER_SOURCE = "";
let modeMatrix = glMatrix.mat4.create();
let projectMatrix = glMatrix.mat4.create();
let points = [
    150, 150, 0,
    200, 150, 0,
    150, 200, 0,
    // 200, 200, 0
]
let u_time;
let tween, u_trans;
let currentIndex = 0
let group = new TWEEN.Group();
main()
function main() {
    console.log(33);
    init();
    initShader()
    handlerEvent()
}
function init() {
    const canvas = document.getElementById("canvas")
    canvas.width = window.innerWidth
    canvas.height = window.innerHeight
    gl = canvas.getContext("webgl2") ||
        canvas.getContext("webgl") ||
        canvas.getContext("experimental-webgl");
    gl.viewport(0, 0, canvas.width, canvas.height)
    gl.clearColor(0.0, 0.0, 0.0, 1.0)
    gl.enable(gl.DEPTH)
    gl.enable(gl.BLEND)
    gl.blendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_CONSTANT_ALPHA)
    if (!gl) {
        console.log('不支持webgl');
    }
}
async function initShader() {

    let vresponse = await fetch("./shader/index.vert.glsl")
    VSHADER_SOURCE = await vresponse.text()
    let fresponse = await fetch("./shader/index.frag.glsl")
    FSHADER_SOURCE = await fresponse.text()

    if (VSHADER_SOURCE && FSHADER_SOURCE) {

        initShaders(gl, VSHADER_SOURCE, FSHADER_SOURCE);
        initBuffer()
    }
}
function initBuffer() {
    let vectorArr = new Float32Array(points)
    let vectorIndex = new Uint16Array([0, 1, 2])

    let buffer = gl.createBuffer()
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer)
    gl.bufferData(gl.ARRAY_BUFFER, vectorArr, gl.STATIC_DRAW)
    let bufferindex = gl.createBuffer()
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, bufferindex)
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, vectorIndex, gl.STATIC_DRAW)
    let a_position = gl.getAttribLocation(gl.program, 'a_Position')
    glMatrix.mat4.ortho(modeMatrix, 0, gl.canvas.width, gl.canvas.height, 0, -1, 1000)

    gl.vertexAttribPointer(a_position, 3, gl.FLOAT, false, 0, 0)
    gl.enableVertexAttribArray(a_position)

    let u_ModelView = gl.getUniformLocation(gl.program, 'u_ModelView')
    let u_ProjectView = gl.getUniformLocation(gl.program, 'u_ProjectView')
    u_trans = gl.getUniformLocation(gl.program, 'u_trans')
    let u_resolition = gl.getUniformLocation(gl.program, 'u_resolition')
    gl.uniform2f(u_resolition, 0.5, 0.5)
    gl.uniform1f(u_trans, 1)
    u_time = gl.getUniformLocation(gl.program, 'u_time')
    glMatrix.mat4.fromXRotation(projectMatrix, 75)
    // glMatrix.mat4.fromYRotation(projectMatrix, 15)

    gl.uniformMatrix4fv(u_ModelView, false, modeMatrix)
    gl.uniformMatrix4fv(u_ProjectView, false, projectMatrix)
    draw()
}
function handlerEvent() {
    document.addEventListener('mousedown', (e) => {

        let x = e.clientX
        let y = e.clientY

        const { left, top, width, height } = gl.canvas.getBoundingClientRect()
        const [cssX, cssY] = [x - left, y - top]
        const [halfx, halfy] = [width / 2, height / 2]
        const [webX, webY] = [(cssX - halfx) / halfx, -(cssY - halfy) / halfy]
        if (hover(x, y)) {
            console.log('0000', points);
            console.log('000---', points[3 * currentIndex], points[3 * currentIndex + 1]);
            points.push(points[3 * currentIndex], points[3 * currentIndex + 1], 0)
        } else {
            points.push(x, y, 0)
        }

        initBuffer()
        let transparent = { count: Math.random() }


    })
    // document.addEventListener('mousemove', handlerMove)
    function handlerMove(e) {
        let count = points.length / 3

        let x = e.clientX
        let y = e.clientY
        if (count > 1) {
            gl.canvas.style.cursor = hover(x, y) ? 'pointer' : 'default'

            points[3 * (count - 1)] = x
            points[3 * (count - 1) + 1] = y

            initBuffer()
        }


    }
    document.addEventListener("contextmenu", (e) => {
        console.log('333356455434343');
        e.preventDefault();
        // document.removeEventListener('mousemove', handlerMove)
        return false
    })

}
let vec2 = glMatrix.vec2.create()
function hover(x, y) {
    let count = points.length / 3
    for (let i = 0; i < count; i++) {
        let oldx = points[3 * i]
        let oldy = points[3 * i + 1]

        if (Math.abs(x - oldx) < 10 && Math.abs(y - oldy) < 10) {
            currentIndex = i
            return true
            // points[3 * i] = x
            // points[3 * i + 1] = y
        }
        return false

    }
}
function draw() {
    // gl.clear(gl.COLOR_BUFFER_BIT)
    // gl.drawArrays(gl.POINTS, 0, points.length / 3)
    // gl.drawArrays(gl.POINTS, 0, points.length / 3);
    //gl.drawArrays(gl.LINE_STRIP, 0, points.length / 3);
    //gl.drawArrays(gl.TRIANGLES, 0, points.length / 3);
    gl.drawElements(gl.TRIANGLES, 3, gl.UNSIGNED_SHORT, 0)
}
run()
let timeOld = 0
function run(time) {
    time = time * 0.001;

    gl.uniform1f(u_time, time);
    requestAnimationFrame(run)
    // draw()
    group && group.update(time)

}