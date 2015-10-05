library graphviz;

import 'dart:js' as js;
import 'dart:async';
import 'package:emscripten/emscripten.dart';

enum Render { DOT, SVG, XDOT, PLAIN }

enum Layout { DOT, NEATO, CIRCO, FDP, SFDP, TWOPI }

String _renderString(Render render) {
  return render.toString().split('.').last.toLowerCase();
}

String _layoutString(Layout layout) {
  return layout.toString().split('.').last.toLowerCase();
}

String graphviz(String dotData,
    {Render render: Render.SVG,
    Layout layout: Layout.DOT,
    List<String> options,
    js.JsObject context}) {
  String format = _renderString(render);
  String engine = _layoutString(layout);
  js.JsObject ctx = (context != null) ? context : js.context;
  return ctx.callMethod("Graphviz", [dotData, format, engine, options]);
}

class Graphviz {
  final AsyncWorker _worker;

  Graphviz([String scriptUrl = 'packages/graphviz/graphviz.js'])
      : _worker = new AsyncWorker(scriptUrl);

  Future<String> layout(String dotData,
      {Render render: Render.SVG,
      Layout layout: Layout.DOT,
      List<String> options}) {
    String format = _renderString(render);
    String engine = _layoutString(layout);

    return _worker.post([dotData, format, engine]);
  }
}
