import 'package:graphviz/graphviz.dart';
import 'package:graphviz/native/graphviz.dart';
import 'package:graphviz/graphs.dart';

main() {
  var gv = new NativeGraphviz();
  var out = gv.layout(cluster, render: Render.SVG);
  print(out);
}
