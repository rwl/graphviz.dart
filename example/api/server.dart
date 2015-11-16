import 'dart:io';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'package:graphviz/api/rpc/server.dart';
import 'package:graphviz/native/graphviz.dart';

main() async {
//  var conn = new WebSocket('ws://localhost:4321');

  var server = await HttpServer.bind('127.0.0.1', 4040);
  await for (HttpRequest req in server) {
    print("req: $req");
//    if (req.uri.path == '/ws') {
    // Upgrade an HttpRequest to a WebSocket connection.
    var socket = await WebSocketTransformer.upgrade(req);
//      socket.listen(handleMsg);

//    socket.listen((a) => print("a: $a"));

    var gv = new NativeGraphviz();
    var server = new rpc.Server(socket);
    var _ = new JsonLayoutService(gv, server);
    server.listen();

//    }
  }
}
