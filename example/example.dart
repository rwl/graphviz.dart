import 'dart:html';
import 'dart:async';
import 'package:graphviz/graphviz.dart';
import 'package:graphviz/web/graphviz.dart';
import 'package:graphviz/graphs.dart';

Node inspect(String s) => new Element.pre()..appendText(s);

Future<Node> example(Graphviz gv, String dotData, Render format,
    [Layout engine = Layout.DOT]) async {
  var result = gv.layout(dotData, render: format, layout: engine);
  if (format == Render.SVG) {
    final doc = new DomParser().parseFromString(result, 'text/xml');
    return document.importNode(doc.documentElement, true);
  } else {
    return inspect(result);
  }
}

main() {
  var gv1 = new WebGraphviz();
  var gv2 = new WebGraphviz();

  example(gv1, cluster, Render.SVG).then((node) {
    document.body.appendHtml("<h1>Cluster (svg output)</h1>");
    document.body.append(node);
  });

  example(gv2, crazy, Render.SVG).then((node) {
    document.body.appendHtml("<h1>Crazy (svg output)</h1>");
    document.body.append(node);
  });

  example(gv1, data, Render.SVG).then((node) {
    document.body.appendHtml("<h1>Data Structures (svg output)</h1>");
    document.body.append(node);
  });

  example(gv2, tables, Render.SVG).then((node) {
    document.body.appendHtml("<h1>Tables (svg output)</h1>");
    document.body.append(node);
  });

  example(gv1, gradients, Render.SVG).then((node) {
    document.body.appendHtml("<h1>Gradients (svg output)</h1>");
    document.body.append(node);
  });

  example(gv2, process, Render.SVG, Layout.NEATO).then((node) {
    document.body
        .appendHtml("<h1>Process States (svg output, neato engine)</h1>");
    document.body.append(node);
  });

  example(gv1, cluster, Render.PLAIN).then((node) {
    document.body.appendHtml("<h1>Cluster (plain output)</h1>");
    document.body.append(node);
  });

  example(gv2, cluster, Render.XDOT).then((node) {
    document.body.appendHtml("<h1>Cluster (xdot output)</h1>");
    document.body.append(node);
  });
}
