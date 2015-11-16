library graphviz.native;

import "dart-ext:gv_ext";

import '../graphviz.dart' as gv;

class NativeGraphviz implements gv.Graphviz {
  String layout(String dotData,
      {gv.Render render: gv.Render.SVG,
      gv.Layout layout: gv.Layout.DOT,
      List<String> options}) {
    return _layout(dotData, render.value, layout.value);
  }

  String _layout(String dotData, String render, String layout)
      native "GV_Layout";
}
