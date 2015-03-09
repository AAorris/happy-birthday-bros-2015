navigator.getUserMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia)

audio = new (window.AudioContext or window.webkitAudioContext)()

audioElement = document.querySelector('audio')
thomas = $('#thomas')
patrick = $('#patrick')
blueglow = $('#blueglow')
redglow = $('#redglow')
bg = $('#background')
position = +document.cookie.split(";")[0] || 0
startPosition = position

currentTime = position

# canvas = document.querySelector('.visualizer')
# graphics = canvas.getContext("2d")
intendedWidth = document.querySelector('.wrapper').clientWidth
intendedHeight = document.querySelector('.wrapper').clientHeight
# canvas.setAttribute('width',intendedWidth)
# canvas.setAttribute('height',intendedHeight)

analyser = audio.createAnalyser()
analyser.minDecibels = -90
analyser.maxDecibels = 60
analyser.smoothingTimeConstant = 0.9

# WIDTH = canvas.width
# HEIGHT = canvas.height
visualize = () ->
  # WIDTH = canvas.width
  # HEIGHT = canvas.height
  s=0.0

  console.log("Visualizing")

  analyser.fftSize = 1024
  bufferLength = analyser.frequencyBinCount
  dataArray = new Uint8Array(bufferLength)

  # graphics.clearRect(0,0,WIDTH,HEIGHT)
  draw = () ->
    drawVisual = requestAnimationFrame(draw)
    analyser.getByteFrequencyData(dataArray)
    # graphics.fillStyle='rgba(10,10,10,64)'
    # graphics.fillRect(0,0,WIDTH,HEIGHT)

    # barWidth = (WIDTH/bufferLength)
    x=0
    # patrick.css("top", HEIGHT/2.5+dataArray[0]/4);
    scale = (data) ->
      data**3/5000
    py = scale(dataArray[1])/5
    bg.css("opacity",py/100)
    lowVoice = 0.5+dataArray[21]/500 + Math.sin(0.6*(audio.currentTime))*0.2;
    highVoice = 0.5+dataArray[33]/200+ Math.sin(0.6*(audio.currentTime+3.14))*0.2;
    xform = (element,voice) ->
      element.css("transform", "scale("+voice+") translateY("+Math.round(py)+"px)");
    xform(patrick,highVoice)
    xform(thomas,lowVoice)
    # xform(redglow,highVoice*6)
    # xform(blueglow,lowVoice*6)
    # for i in [0..bufferLength] by 1
    #   barHeight = dataArray[i]**3/5000
      # graphics.fillStyle = 'rgb(' + (dataArray[i]+100+',50,50)')
      # graphics.fillRect(x,HEIGHT-barHeight,barWidth,barHeight)
    #   x+=barWidth+10
  draw()
  setInterval(()->
    songTime=audio.currentTime+startPosition
    document.cookie=songTime
    console.log(songTime)
  1000)

source = audio.createMediaElementSource(document.querySelector('audio'))
source.connect(analyser)
analyser.connect(audio.destination)
visualize()

window.onresize = () ->
  intendedWidth = document.querySelector('.wrapper').clientWidth
  intendedHeight = document.querySelector('.wrapper').clientHeight
  # canvas.setAttribute('width',intendedWidth)
  # canvas.setAttribute('height',intendedHeight)
  # WIDTH = canvas.width
  # HEIGHT = canvas.height
##======================================
# dataArray = new Uint8Array(bufferLength)
##======================================

# data="byte"
# domain="time"

# switch
#   when data is "byte" and domain is "frequency" then analyser.getByteFrequencyData(dataArray)
#   when data is "byte" and domain is "time" then analyser.getByteTimeDomainData(dataArray)
#   when data is "float" and domain is "frequency" then analyser.getFloatFrequencyData(dataArray)
#   when data is "float" and domain is "time" then analyser.getFloatTimeDomainData(dataArray)
