$(document).on("ready", ()->

  patrick = $("#patrick")
  thomas = $("#thomas")
  redglow = $("#redglow")
  blueglow = $("#blueglow")
  downglow = $("#downglow")
  twins = $(".twin")

  container = $("#container")

  w = window.innerWidth
  h = window.innerHeight

  center = (el, xFactor) ->
    imgW = el.css("height").split("px")[0]
    imgH = el.css("width").split("px")[0]
    w = window.innerWidth
    h = window.innerHeight
    offset = h/2

    el.css("position", "absolute")
    el.animate({
        top: h/2-imgH/2+"px"
        left: w*xFactor-imgW/2+"px"
      },{
        queue:false, duration:1000
        })

  $(window).resize(()->
    center(patrick,0.75)
    center(thomas,0.33)
    center(redglow,0.75)
    center(blueglow,0.33)
    )

  patrick.load(()->center(patrick,0.75))
  thomas.load(()->center(thomas,0.33))
  redglow.load(()->center(redglow,0.75))
  blueglow.load(()->center(blueglow,0.33))
)
