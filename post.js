  return Module["ccall"]("vizRenderFromString", "string",
    ["string", "string", "string", "string"],
    [src, format, engine, options]);
}

if (this.document === undefined) {
  // Web Worker mode
  
  // Incoming message = { payload : { source, format, engine, options },
  //   workerHandle }
  // Outgoing message = { payload : "", workerHandle }

  // workerHandle is a random Number (assigned by the host) to match 
  // request and response.

  this.onmessage = function (event) {
    var payload = event["data"]["payload"];
    var result;
    try {
      result = { "payload" : Graphviz(payload["source"], payload["format"],
        payload["engine"], payload["options"]) };
    } catch (error) {
      result = { "error" : error };
    }
    result["workerHandle"] = event["data"]["workerHandle"];
    this.postMessage(result);
  }
}

