#include "cdt.h"
#include "gvc.h"

extern gvplugin_library_t gvplugin_dot_layout_LTX_library;
extern gvplugin_library_t gvplugin_neato_layout_LTX_library;
extern gvplugin_library_t gvplugin_core_LTX_library;

GVC_t *context = NULL;
char *last_result = NULL;

__attribute__((used)) char* vizRenderFromString(const char *string,
                                                const char *format,
                                                const char *engine,
                                                char *options) {
  if (context == NULL) {
    context = gvContext();
    gvAddLibrary(context, &gvplugin_core_LTX_library);
    gvAddLibrary(context, &gvplugin_dot_layout_LTX_library);
    gvAddLibrary(context, &gvplugin_neato_layout_LTX_library);
  }

  // First pass - count the number of extra options separated with '|'
  fprintf(stderr, "options is \"%s\"\n", options);
  int options_count = 0;
  if (options && options[0]) {
    char current;
    for (int pos = 0; (current = options[pos]); pos++) {
      if (current == '|') {
        options_count++;
      }
    }
    options_count++;
    fprintf(stderr, "Found %d options\n", options_count);
  }
  // Second pass - fill all the options
  const char *argv[3 + options_count];
  argv[0] = engine;
  argv[1] = "-T";
  argv[2] = format;
  if (options_count > 0) {
    options_count = 0;
    int pos = 0, prev_pos = 0;
    char current;
    while ((current = options[pos++])) {
      if (current == '|') {
        argv[3 + options_count] = options + prev_pos;
        options[pos - 1] = 0;
        prev_pos = pos;
        options_count++;
      }
    }
    argv[3 + options_count] = options + prev_pos;
  }

  if (gvParseArgs(context, sizeof(argv) / sizeof(argv[0]), (char**)argv)) {
    fprintf(stderr, "viz.js: failed to set the engine or the output format\n");
    return NULL;
  }

  Agraph_t *graph = agmemread((char*)string);
  if (!graph) {
    fprintf(stderr, "viz.js: failed to parse the supplied graph string\n");
    return NULL;
  }
  gvLayoutJobs(context, graph);

  char *result = NULL;
  unsigned int length;
  gvRenderData(context, graph, format, &result, &length);

  gvFreeLayout(context, graph);
  agclose(graph);

  if (last_result != NULL) {
    gvFreeRenderData(last_result);
  }
  last_result = result;

  return result;
}
