  return Module["ccall"]("vizRenderFromString", "string",
    ["string", "string", "string", "string"],
    [src, format, engine, options]);
}

if (this.document === undefined) {
  // input  = [ id, [ source, format, engine, options ] ]
  // output = [ id, output ]
  // output = [ id, [ "error", error ] ]

  this.onmessage = function (event) {
    if (!Array.isArray(event["data"])) {
      postMessage("internal error: expected array");
      return;
    }

    var handle = event["data"][0];
    var payload = event["data"][1];
    if (handle === undefined && payload === undefined) {
      postMessage("internal error: no payload");
      return;
    }

    var result;
    try {
      result = Graphviz(payload[0], payload[1], payload[2], payload[3]);
    } catch (error) {
      result = [ "error", error.toString() ];
    }
    var msg = [handle, result];
    this.postMessage(msg);
  }
}
