library graphviz.web;

import 'dart:js' as js;
import 'dart:async';
import 'package:emscripten/emscripten.dart';

import '../graphviz.dart' as gv;

class WebGraphviz implements gv.Graphviz {
  final js.JsObject _ctx;

  WebGraphviz([js.JsObject context])
      : _ctx = (context != null) ? context : js.context;

  String layout(String dotData,
      {gv.Render render: gv.Render.SVG,
      gv.Layout layout: gv.Layout.DOT,
      List<String> options}) {
    String format = render.value;
    String engine = layout.value;
    return _ctx.callMethod("Graphviz", [dotData, format, engine, options]);
  }
}

class AsyncWebGraphviz {
  final AsyncWorker _worker;

  AsyncWebGraphviz([String scriptUrl = 'packages/graphviz/web/graphviz.js'])
      : _worker = new AsyncWorker(scriptUrl);

  Future<String> layout(String dotData,
      {gv.Render render: gv.Render.SVG,
      gv.Layout layout: gv.Layout.DOT,
      List<String> options}) {
    return _worker.post([dotData, render.value, layout.value]);
  }
}
