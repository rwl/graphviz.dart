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
  String format = render.toString().split('.').last.toLowerCase();
  String engine = layout.toString().split('.').last.toLowerCase();
  js.JsObject ctx = (context != null) ? context : js.context;
  return ctx.callMethod("Graphviz", [dotData, format, engine, options]);
}
