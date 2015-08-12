# graphviz.dart

A [Dart][] package and [Emscripten][] module for [Graphviz][].

## Usage

To render as SVG (produces an XML string):

```dart
var svg = graphviz("digraph { a -> b; }", render: Render.SVG);
```

### Asynchronous API

To prevent UI freeze graph layout may be computed in a separate
thread using Web Workers:

```dart
var gv = new Graphviz();
gv.layout("digraph { a -> b; }").then((String result) {
  print(result);
});
```

## Examples

- [Web Worker](http://rwl.github.io/graphviz.dart/example.html)
- [Form](http://rwl.github.io/graphviz.dart/form.html)

Try comparing page load and refresh times between [Firefox][] and
other browsers.

## Credits

This project is based on work by Mike Daines, Satoshi Ueyama and
Brenton Partridge:

- [viz.js](https://github.com/mdaines/viz.js)
- [livizjs](https://github.com/gyuque/livizjs)
- [graphviz.js](https://github.com/bpartridge/graphviz.js)

Thanks to the following contributors:

  jbogard
  KylePDavis
  siefkenj
  srathbun
  vmarkovtsev

[Dart]: https://www.dartlang.org/
[Emscripten]: http://emscripten.org/
[Graphviz]: http://www.graphviz.org/
[Firefox]: https://www.mozilla.org/en-US/firefox/android/
