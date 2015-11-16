import 'dart:html';
import 'dart:async';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'package:graphviz/api/graphviz.pb.dart';
import 'package:graphviz/api/rpc/client.dart';
import 'package:graphviz/graphs.dart';

Node inspect(String s) => new Element.pre()..appendText(s);

Future<Node> example(LayoutServiceApi gv, String dotData, Render format,
    [Layout engine = Layout.DOT]) async {
  var request = new LayoutRequest()..data = dotData;
  var response = await gv.layout(null, request);
  if (format == Render.SVG) {
    final doc = new DomParser().parseFromString(response.data, 'text/xml');
    return document.importNode(doc.documentElement, true);
  } else {
    return inspect(response.data);
  }
}

main() {
  var conn = new WebSocket('ws://localhost:4321');
  conn.onOpen.listen((_) {
    var client =
        new rpc.Client(conn.onMessage.map((MessageEvent evt) => evt.data));
    var client2 = new JsonRpcClient('LayoutService', client);
    var api1 = new LayoutServiceApi(client2);
    var api2 = new LayoutServiceApi(client2);

    example(api1, cluster, Render.SVG).then((node) {
      document.body.appendHtml("<h1>Cluster (svg output)</h1>");
      document.body.append(node);
    });

    example(api2, crazy, Render.SVG).then((node) {
      document.body.appendHtml("<h1>Crazy (svg output)</h1>");
      document.body.append(node);
    });

    example(api1, data, Render.SVG).then((node) {
      document.body.appendHtml("<h1>Data Structures (svg output)</h1>");
      document.body.append(node);
    });

    example(api2, tables, Render.SVG).then((node) {
      document.body.appendHtml("<h1>Tables (svg output)</h1>");
      document.body.append(node);
    });

    example(api1, gradients, Render.SVG).then((node) {
      document.body.appendHtml("<h1>Gradients (svg output)</h1>");
      document.body.append(node);
    });

    example(api2, process, Render.SVG, Layout.NEATO).then((node) {
      document.body
          .appendHtml("<h1>Process States (svg output, neato engine)</h1>");
      document.body.append(node);
    });

    example(api1, cluster, Render.PLAIN).then((node) {
      document.body.appendHtml("<h1>Cluster (plain output)</h1>");
      document.body.append(node);
    });

    example(api2, cluster, Render.XDOT).then((node) {
      document.body.appendHtml("<h1>Cluster (xdot output)</h1>");
      document.body.append(node);
    });
  });
}
