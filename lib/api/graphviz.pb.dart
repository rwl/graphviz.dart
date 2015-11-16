///
//  Generated code. Do not modify.
///
library graphviz.layout_graphviz;

import 'dart:async';

import 'package:protobuf/protobuf.dart';

class Render extends ProtobufEnum {
  static const Render GV_DOT = const Render._(1, 'GV_DOT');
  static const Render SVG = const Render._(2, 'SVG');
  static const Render XDOT = const Render._(3, 'XDOT');
  static const Render PLAIN = const Render._(4, 'PLAIN');

  static const List<Render> values = const <Render> [
    GV_DOT,
    SVG,
    XDOT,
    PLAIN,
  ];

  static final Map<int, Render> _byValue = ProtobufEnum.initByValue(values);
  static Render valueOf(int value) => _byValue[value];
  static void $checkItem(Render v) {
    if (v is !Render) checkItemFailed(v, 'Render');
  }

  const Render._(int v, String n) : super(v, n);
}

class Layout extends ProtobufEnum {
  static const Layout DOT = const Layout._(1, 'DOT');
  static const Layout NEATO = const Layout._(2, 'NEATO');
  static const Layout CIRCO = const Layout._(3, 'CIRCO');
  static const Layout FDP = const Layout._(4, 'FDP');
  static const Layout SFDP = const Layout._(5, 'SFDP');
  static const Layout TWOPI = const Layout._(6, 'TWOPI');

  static const List<Layout> values = const <Layout> [
    DOT,
    NEATO,
    CIRCO,
    FDP,
    SFDP,
    TWOPI,
  ];

  static final Map<int, Layout> _byValue = ProtobufEnum.initByValue(values);
  static Layout valueOf(int value) => _byValue[value];
  static void $checkItem(Layout v) {
    if (v is !Layout) checkItemFailed(v, 'Layout');
  }

  const Layout._(int v, String n) : super(v, n);
}

class LayoutRequest extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LayoutRequest')
    ..a(1, 'data', PbFieldType.OS)
    ..e(2, 'render', PbFieldType.OE, Render.GV_DOT, Render.valueOf)
    ..e(3, 'layout', PbFieldType.OE, Layout.DOT, Layout.valueOf)
    ..hasRequiredFields = false
  ;

  LayoutRequest() : super();
  LayoutRequest.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LayoutRequest.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LayoutRequest clone() => new LayoutRequest()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LayoutRequest create() => new LayoutRequest();
  static PbList<LayoutRequest> createRepeated() => new PbList<LayoutRequest>();
  static LayoutRequest getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLayoutRequest();
    return _defaultInstance;
  }
  static LayoutRequest _defaultInstance;
  static void $checkItem(LayoutRequest v) {
    if (v is !LayoutRequest) checkItemFailed(v, 'LayoutRequest');
  }

  String get data => $_get(0, 1, '');
  void set data(String v) { $_setString(0, 1, v); }
  bool hasData() => $_has(0, 1);
  void clearData() => clearField(1);

  Render get render => $_get(1, 2, null);
  void set render(Render v) { setField(2, v); }
  bool hasRender() => $_has(1, 2);
  void clearRender() => clearField(2);

  Layout get layout => $_get(2, 3, null);
  void set layout(Layout v) { setField(3, v); }
  bool hasLayout() => $_has(2, 3);
  void clearLayout() => clearField(3);
}

class _ReadonlyLayoutRequest extends LayoutRequest with ReadonlyMessageMixin {}

class LayoutResponse extends GeneratedMessage {
  static final BuilderInfo _i = new BuilderInfo('LayoutResponse')
    ..a(1, 'data', PbFieldType.OS)
    ..hasRequiredFields = false
  ;

  LayoutResponse() : super();
  LayoutResponse.fromBuffer(List<int> i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  LayoutResponse.fromJson(String i, [ExtensionRegistry r = ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  LayoutResponse clone() => new LayoutResponse()..mergeFromMessage(this);
  BuilderInfo get info_ => _i;
  static LayoutResponse create() => new LayoutResponse();
  static PbList<LayoutResponse> createRepeated() => new PbList<LayoutResponse>();
  static LayoutResponse getDefault() {
    if (_defaultInstance == null) _defaultInstance = new _ReadonlyLayoutResponse();
    return _defaultInstance;
  }
  static LayoutResponse _defaultInstance;
  static void $checkItem(LayoutResponse v) {
    if (v is !LayoutResponse) checkItemFailed(v, 'LayoutResponse');
  }

  String get data => $_get(0, 1, '');
  void set data(String v) { $_setString(0, 1, v); }
  bool hasData() => $_has(0, 1);
  void clearData() => clearField(1);
}

class _ReadonlyLayoutResponse extends LayoutResponse with ReadonlyMessageMixin {}

class LayoutServiceApi {
  RpcClient _client;
  LayoutServiceApi(this._client);

  Future<LayoutResponse> layout(ClientContext ctx, LayoutRequest request) {
    var emptyResponse = new LayoutResponse();
    return _client.invoke(ctx, 'LayoutService', 'Layout', request, emptyResponse);
  }
}

abstract class LayoutServiceBase extends GeneratedService {
  Future<LayoutResponse> layout(ServerContext ctx, LayoutRequest request);

  GeneratedMessage createRequest(String method) {
    switch (method) {
      case 'Layout': return new LayoutRequest();
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Future<GeneratedMessage> handleCall(ServerContext ctx, String method, GeneratedMessage request) {
    switch (method) {
      case 'Layout': return layout(ctx, request);
      default: throw new ArgumentError('Unknown method: $method');
    }
  }

  Map<String, dynamic> get $json => LayoutService$json;
  Map<String, dynamic> get $messageJson => LayoutService$messageJson;
}

const Render$json = const {
  '1': 'Render',
  '2': const [
    const {'1': 'GV_DOT', '2': 1},
    const {'1': 'SVG', '2': 2},
    const {'1': 'XDOT', '2': 3},
    const {'1': 'PLAIN', '2': 4},
  ],
};

const Layout$json = const {
  '1': 'Layout',
  '2': const [
    const {'1': 'DOT', '2': 1},
    const {'1': 'NEATO', '2': 2},
    const {'1': 'CIRCO', '2': 3},
    const {'1': 'FDP', '2': 4},
    const {'1': 'SFDP', '2': 5},
    const {'1': 'TWOPI', '2': 6},
  ],
};

const LayoutRequest$json = const {
  '1': 'LayoutRequest',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 9},
    const {'1': 'render', '3': 2, '4': 1, '5': 14, '6': '.graphviz.layout.Render'},
    const {'1': 'layout', '3': 3, '4': 1, '5': 14, '6': '.graphviz.layout.Layout'},
  ],
};

const LayoutResponse$json = const {
  '1': 'LayoutResponse',
  '2': const [
    const {'1': 'data', '3': 1, '4': 1, '5': 9},
  ],
};

const LayoutService$json = const {
  '1': 'LayoutService',
  '2': const [
    const {'1': 'Layout', '2': '.graphviz.layout.LayoutRequest', '3': '.graphviz.layout.LayoutResponse'},
  ],
};

const LayoutService$messageJson = const {
  '.graphviz.layout.LayoutRequest': LayoutRequest$json,
  '.graphviz.layout.LayoutResponse': LayoutResponse$json,
};

