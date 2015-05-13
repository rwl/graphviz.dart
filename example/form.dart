
import 'dart:html';
import 'package:graphviz/graphviz.dart';
import 'package:graphviz/graphs.dart';

Node inspect(String s) => new Element.pre()..appendText(s);

var formats = {
  'dot': Render.DOT,
  'plain': Render.PLAIN,
  'svg': Render.SVG,
  'xdot': Render.XDOT
};

var engines = {
  'dot': Layout.DOT,
  'neato': Layout.NEATO
};

main() {
  TextAreaElement input = document.getElementById("input");
  input.value = cluster;

  document.getElementById("generate").onClick.listen((e) {

    SelectElement format = document.getElementById("format");
    SelectElement engine = document.getElementById("engine");

    Render render = formats[format.value];
    Layout layout = engines[engine.value];
    var result = graphviz(input.value, render: render, layout: layout);

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
