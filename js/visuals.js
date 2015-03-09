$(document).on("ready", function() {
  var blueglow, center, container, downglow, h, patrick, redglow, thomas, twins, w;
  patrick = $("#patrick");
  thomas = $("#thomas");
  redglow = $("#redglow");
  blueglow = $("#blueglow");
  downglow = $("#downglow");
  twins = $(".twin");
  container = $("#container");
  w = window.innerWidth;
  h = window.innerHeight;
  center = function(el, xFactor) {
    var imgH, imgW, offset;
    imgW = el.css("height").split("px")[0];
    imgH = el.css("width").split("px")[0];
    w = window.innerWidth;
    h = window.innerHeight;
    offset = h / 2;
    el.css("position", "absolute");
    return el.animate({
      top: h / 2 - imgH / 2 + "px",
      left: w * xFactor - imgW / 2 + "px"
    }, {
      queue: false,
      duration: 1000
    });
  };
  $(window).resize(function() {
    center(patrick, 0.75);
    center(thomas, 0.33);
    center(redglow, 0.75);
    return center(blueglow, 0.33);
  });
  patrick.load(function() {
    return center(patrick, 0.75);
  });
  thomas.load(function() {
    return center(thomas, 0.33);
  });
  redglow.load(function() {
    return center(redglow, 0.75);
  });
  return blueglow.load(function() {
    return center(blueglow, 0.33);
  });
});
