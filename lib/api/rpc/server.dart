library dpower.api.src.server;

import 'dart:async';
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;
import 'package:protobuf/protobuf.dart';
import '../graphviz.pb.dart' as pb;
import '../../graphviz.dart';

final _render = <pb.Render, Render>{
  pb.Render.GV_DOT: Render.DOT,
  pb.Render.SVG: Render.SVG,
  pb.Render.XDOT: Render.XDOT,
  pb.Render.PLAIN: Render.PLAIN
};

final _layout = <pb.Layout, Layout>{
  pb.Layout.DOT: Layout.DOT,
  pb.Layout.NEATO: Layout.NEATO,
  pb.Layout.CIRCO: Layout.CIRCO,
  pb.Layout.FDP: Layout.FDP,
  pb.Layout.SFDP: Layout.SFDP,
  pb.Layout.TWOPI: Layout.TWOPI
};

class JsonLayoutService extends pb.LayoutServiceBase {
  final Graphviz _graphviz;

  JsonLayoutService(this._graphviz, rpc.Server server,
      [String methodName = "Layout"]) {
    server.registerMethod(methodName, (rpc.Parameters params) async {
      var request = createRequest(methodName);
      request.mergeFromJsonMap(params.asMap);
//      print('params: $params \nreq: $request \nparams: ${params.asMap}');
      var response = await handleCall(new ServerContext(), methodName, request);
      print('response: $response');
      return response.writeToJsonMap();
    });
  }

  Future<pb.LayoutResponse> layout(
      ServerContext ctx, pb.LayoutRequest request) async {
    var response = new pb.LayoutResponse();
    try {
      print('request: ${request.data}');
      String data = request.data;
      Render render = _render[request.render];
      Layout layout = _layout[request.layout];
//    data = _graphviz.layout(data, render: render, layout: layout);
      response.data = data;
    } catch (e) {
      throw new rpc.RpcException(6, e.toString());
    }
    return response;
  }
}
