import 'dart:io';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'package:graphviz/api/graphviz.pb.dart' as pb;
import 'package:graphviz/api/rpc/client.dart';
import 'package:graphviz/graphs.dart';

main() async {
  var conn = await WebSocket.connect('ws://127.0.0.1:4040/ws');
  var client = new rpc.Client(conn);
  var client2 = new JsonRpcClient('LayoutService', client);
  var api = new pb.LayoutServiceApi(client2);
  var request = new pb.LayoutRequest();
  request.data = cluster;
  request.render = pb.Render.SVG;
  var response = await api.layout(null, request);
  print(response.data);
  conn.close();
}
