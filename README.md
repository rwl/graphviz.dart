graphviz.dart
=============

A [Dart][] package and [Emscripten][] module for [Graphviz][].

To render as SVG (produces an XML string):

    var svg = graphviz("digraph { a -> b; }", render: Render.SVG);

See examples here:

  http://rwl.github.io/graphviz.dart/example.html  
  http://rwl.github.io/graphviz.dart/form.html

This project is based on work by Mike Daines, Satoshi Ueyama and Brenton
Partridge:

  https://github.com/mdaines/viz.js  
  https://github.com/gyuque/livizjs  
  https://github.com/bpartridge/graphviz.js

Thanks to the following contributors:

  jbogard  
  KylePDavis  
  siefkenj  
  srathbun  
  vmarkovtsev

[Dart]: https://www.dartlang.org/
[Emscripten]: http://emscripten.org/
[Graphviz]: http://www.graphviz.org/

