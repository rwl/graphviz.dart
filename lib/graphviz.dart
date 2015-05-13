library graphviz;

import 'dart:js' as js;

enum Render {
  DOT, SVG, XDOT, PLAIN
}

enum Layout {
  DOT, NEATO, CIRCO, FDP, SFDP, TWOPI
}

String graphviz(String dotData, {Render render: Render.SVG,
  Layout layout: Layout.DOT, List<String> options, js.JsObject context}) {
  var format = render.toString().split('.').last.toLowerCase();
  var engine = layout.toString().split('.').last.toLowerCase();
  var ctx = context != null ? context : js.context;
  return ctx.callMethod("Graphviz", [dotData, format, engine, options]);
}
