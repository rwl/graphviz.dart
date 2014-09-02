Viz.js
======

A hack to put Graphviz on the web. You should probably check out dagre, though:

  https://github.com/cpettitt/dagre  
  https://github.com/cpettitt/dagre-d3  

To render as SVG (produces an XML string):

    svg = Viz("digraph { a -> b; }", "svg");

See examples here:

  http://mdaines.github.io/viz.js/example.html  
  http://mdaines.github.io/viz.js/form.html

Compiled versions are available on the releases page:

  https://github.com/mdaines/viz.js/releases

This project is based on work by Satoshi Ueyama and Brenton Partridge:

  https://github.com/gyuque/livizjs  
  https://github.com/bpartridge/graphviz.js

Thanks to the following contributors:

  jbogard  
  KylePDavis  
  siefkenj  
  srathbun  
  vmarkovtsev

Usage
=====

    Viz(src, format="svg", engine="dot", options=null)

* src is the string representation of the graph written in Dot language.
* format is the graph output format in terms of dot -T. Since the result of the
function is returned as a string, the only sane formats are "dot" and "svg".
Typically, one would use "svg" to display the rendered result.
* engine is the Graphviz layout engine to use. Can be any from "dot", "neato",
"circo", "twopi" or others. Usually, one is satisfied with "dot" or "neato".
* options are the array of extra command line arguments which are virtually added
to the corresponding engine invocation (thanks to GVC API's gvParseArgs()). To
get an idea what such options can be, execute "dot --help" in your system's
terminal. As an example, options=["-n"] makes neato enter "no layout" mode to
render graphs already converted to "dot" output format as-is.
