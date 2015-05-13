
import 'dart:html';
import 'package:graphviz/graphviz.dart';
import 'package:graphviz/graphs.dart';

Node inspect(String s) => new Element.pre()..appendText(s);

Node example(String dotData, Render format, [Layout engine=Layout.DOT]) {
  var result;
  try {
    result = graphviz(dotData, render: format, layout: engine);
    if (format == Render.SVG) {
      final doc = new DomParser().parseFromString(result, 'text/xml');
      return document.importNode(doc.documentElement, true);
    } else {
      return inspect(result);
    }
  } catch(e) {
    return inspect(e.toString());
  }
}

main() {
  document.body.appendHtml("<h1>Cluster (svg output)</h1>");
  document.body.append(example(cluster, Render.SVG));

  document.body.appendHtml("<h1>Crazy (svg output)</h1>");
  document.body.append(example(crazy, Render.SVG));

  document.body.appendHtml("<h1>Data Structures (svg output)</h1>");
  document.body.append(example(data, Render.SVG));

  document.body.appendHtml("<h1>Tables (svg output)</h1>");
  document.body.append(example(tables, Render.SVG));

  document.body.appendHtml("<h1>Gradients (svg output)</h1>");
  document.body.append(example(gradients, Render.SVG));

  document.body.appendHtml("<h1>Process States (svg output, neato engine)</h1>");
  document.body.append(example(process, Render.SVG, Layout.NEATO));

  document.body.appendHtml("<h1>Cluster (plain output)</h1>");
  document.body.append(example(cluster, Render.PLAIN));

  document.body.appendHtml("<h1>Cluster (xdot output)</h1>");
  document.body.append(example(cluster, Render.XDOT));
}
