library dpower.api.src.server;

import 'dart:async';
import 'package:protobuf/protobuf.dart' as pb;
import 'package:json_rpc_2/json_rpc_2.dart' as rpc;

class JsonRpcClient implements pb.RpcClient {
  Map<String, rpc.Client> _clients;

  JsonRpcClient(String serviceName, rpc.Client client) {
    _clients = {serviceName: client};
  }

  JsonRpcClient.map(this._clients);

  /// Sends a request to a server and returns the reply.
  ///
  /// The implementation should serialize the request as binary or JSON, as
  /// appropriate. It should merge the reply into [emptyResponse] and
  /// return it.
  Future<pb.GeneratedMessage> invoke(
      pb.ClientContext ctx,
      String serviceName,
      String methodName,
      pb.GeneratedMessage request,
      pb.GeneratedMessage emptyResponse) async {
    if (_clients.containsKey(serviceName)) {
      var client = _clients[serviceName];
      var response =
          await client.sendRequest(methodName, request.writeToJsonMap());
      emptyResponse.mergeFromJsonMap(response);
    } else {
      throw serviceName;
    }
    return emptyResponse;
  }
}
