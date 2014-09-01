window["Viz"] = function(src, format, engine, options) {
  if (typeof(format) === 'undefined') {
    format = 'svg';
  }
  if (typeof(engine) === 'undefined') {
    engine = 'dot';
  }
  if (Array.isArray(options)) {
    options = options.join('|');
  } else {
    options = null;
  }

  var Module = {};
  Module["return"] = "";
  Module["print"] = function(text) {
    Module["return"] += text + "\n";
  }
