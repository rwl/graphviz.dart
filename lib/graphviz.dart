library graphviz.src;

class Render {
  final value;
  const Render._(this.value);
  toString() => 'Render.$value';

  static const DOT = const Render._('dot');
  static const SVG = const Render._('svg');
  static const XDOT = const Render._('xdot');
  static const PLAIN = const Render._('plain');

  static const List<Render> values = const [
    Render.DOT,
    Render.SVG,
    Render.XDOT,
    Render.PLAIN
  ];
}

class Layout {
  final value;
  const Layout._(this.value);
  toString() => 'Layout.$value';

  static const DOT = const Layout._('dot');
  static const NEATO = const Layout._('neato');
  static const CIRCO = const Layout._('circo');
  static const FDP = const Layout._('fdp');
  static const SFDP = const Layout._('sfdp');
  static const TWOPI = const Layout._('twopi');

  static const List<Layout> values = const [
    DOT,
    NEATO,
    CIRCO,
    FDP,
    SFDP,
    TWOPI
  ];
}

abstract class Graphviz {
  String layout(String dotData,
      {Render render: Render.SVG,
      Layout layout: Layout.DOT,
      List<String> options});
}
