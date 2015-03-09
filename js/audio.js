var analyser, audio, audioElement, blueglow, currentTime, intendedHeight, intendedWidth, patrick, position, redglow, source, startPosition, thomas, visualize;

navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;

audio = new (window.AudioContext || window.webkitAudioContext)();

audioElement = document.querySelector('audio');

thomas = $('#thomas');

patrick = $('#patrick');

blueglow = $('#blueglow');

redglow = $('#redglow');

position = +document.cookie.split(";")[0] || 0;

startPosition = position;

currentTime = position;

intendedWidth = document.querySelector('.wrapper').clientWidth;

intendedHeight = document.querySelector('.wrapper').clientHeight;

analyser = audio.createAnalyser();

analyser.minDecibels = -90;

analyser.maxDecibels = 60;

analyser.smoothingTimeConstant = 0.9;

visualize = function() {
  var bufferLength, dataArray, draw, s;
  s = 0.0;
  console.log("Visualizing");
  analyser.fftSize = 1024;
  bufferLength = analyser.frequencyBinCount;
  dataArray = new Uint8Array(bufferLength);
  draw = function() {
    var drawVisual, highVoice, lowVoice, py, scale, x, xform;
    drawVisual = requestAnimationFrame(draw);
    analyser.getByteFrequencyData(dataArray);
    x = 0;
    scale = function(data) {
      return Math.pow(data, 3) / 5000;
    };
    py = scale(dataArray[1]) / 5;
    lowVoice = 0.5 + dataArray[21] / 500;
    highVoice = 0.5 + dataArray[33] / 200 - 0.1;
    xform = function(element, voice) {
      return element.css("transform", "scale(" + voice + ") translateY(" + Math.round(py) + "px)");
    };
    xform(patrick, highVoice);
    return xform(thomas, lowVoice);
  };
  draw();
  return setInterval(function() {
    var songTime;
    songTime = audio.currentTime + startPosition;
    document.cookie = songTime;
    return console.log(songTime);
  }, 1000);
};

source = audio.createMediaElementSource(document.querySelector('audio'));

source.connect(analyser);

analyser.connect(audio.destination);

visualize();

window.onresize = function() {
  intendedWidth = document.querySelector('.wrapper').clientWidth;
  return intendedHeight = document.querySelector('.wrapper').clientHeight;
};
