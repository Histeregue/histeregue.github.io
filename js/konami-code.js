// Thanks to Wes Bos from the Channel Wes Bos https://youtu.be/_A5eVOIqGLU
const pressed = [];
const secretCode = 'histeregue';
window.addEventListener('keyup', (e) => {
    pressed.push(e.key);
    pressed.splice(-secretCode.length - 1, pressed.length - secretCode.length);
    if(pressed.join('').includes(secretCode)) {
        console.log('DING DING!');
    }
});