import 'dart:html';
import 'package:graphviz/graphviz.dart';
import 'package:graphviz/web/graphviz.dart';
import 'package:graphviz/graphs.dart';

Node inspect(String s) => new Element.pre()..appendText(s);

Map<String, Render> formats =
    new Map.fromIterable(Render.values, key: (r) => r.value, value: (r) => r);

Map<String, Layout> engines =
    new Map.fromIterable(Layout.values, key: (l) => l.value, value: (l) => l);

main() {
  TextAreaElement input = document.getElementById("input");
  input.value = cluster;
  var gv = new WebGraphviz();

  document.getElementById("generate").onClick.listen((e) {
    SelectElement format = document.getElementById("format");
    SelectElement engine = document.getElementById("engine");

    Render render = formats[format.value];
    Layout layout = engines[engine.value];
    var result = gv.layout(input.value, render: render, layout: layout);

    DivElement output = document.getElementById("output");
    output.children.toList().forEach((c) => c.remove());
    if (render == Render.SVG) {
      final doc = new DomParser().parseFromString(result, 'text/xml');
      output.append(document.importNode(doc.documentElement, true));
    }

    DivElement inspectNode = document.getElementById("inspect");
    inspectNode.children.toList().forEach((c) => c.remove());
    inspectNode.append(inspect(result));
  });
}
