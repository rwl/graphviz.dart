#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <inttypes.h>

#include "dart_api.h"

#include "cdt.h"
#include "gvc.h"

extern gvplugin_library_t gvplugin_dot_layout_LTX_library;
extern gvplugin_library_t gvplugin_neato_layout_LTX_library;
extern gvplugin_library_t gvplugin_core_LTX_library;

GVC_t *context = NULL;
char *last_result = NULL;


Dart_NativeFunction ResolveName(Dart_Handle name, int argc,
    bool* auto_setup_scope);

DART_EXPORT Dart_Handle gv_ext_Init(Dart_Handle parent_library)
{
  if (Dart_IsError(parent_library)) {
    return parent_library;
  }

  Dart_Handle result_code = Dart_SetNativeResolver(parent_library, ResolveName,
      NULL);
  if (Dart_IsError(result_code)) {
    return result_code;
  }

  return Dart_Null();
}


Dart_Handle HandleError(Dart_Handle handle) {
  if (Dart_IsError(handle)) {
    Dart_PropagateError(handle);
  }
  return handle;
}


void GV_Layout(Dart_NativeArguments arguments) {
  void* peer;
  Dart_Handle obj;
  const char *data, *format, *engine;
  char *options = NULL;

  Dart_EnterScope();

  obj =  HandleError(Dart_GetNativeStringArgument(arguments, 1, &peer));
//  obj = HandleError(Dart_GetNativeArgument(arguments, 1));
  HandleError(Dart_StringToCString(obj, &data));

  obj =  HandleError(Dart_GetNativeStringArgument(arguments, 2, &peer));
  HandleError(Dart_StringToCString(obj, &format));

  obj =  HandleError(Dart_GetNativeStringArgument(arguments, 3, &peer));
  HandleError(Dart_StringToCString(obj, &engine));


  if (context == NULL) {
    context = gvContext();
    gvAddLibrary(context, &gvplugin_core_LTX_library);
    gvAddLibrary(context, &gvplugin_dot_layout_LTX_library);
    gvAddLibrary(context, &gvplugin_neato_layout_LTX_library);
  }

  // First pass - count the number of extra options separated with '|'
//  fprintf(stderr, "options is \"%s\"\n", options);
  int options_count = 0;
  if (options && options[0]) {
    char current;
    for (int pos = 0; (current = options[pos]); pos++) {
      if (current == '|') {
        options_count++;
      }
    }
    options_count++;
//    fprintf(stderr, "Found %d options\n", options_count);
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
    HandleError(Dart_NewApiError("engine or format error"));
    return;
  }

  Agraph_t *graph = agmemread((char*)data);
  if (!graph) {
    HandleError(Dart_NewApiError("parsing error"));
    return;
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

  obj = HandleError(Dart_NewStringFromCString((const char*) result));
  Dart_SetReturnValue(arguments, obj);

  Dart_ExitScope();
}


Dart_NativeFunction ResolveName(Dart_Handle name, int argc,
    bool* auto_setup_scope) {
  if (!Dart_IsString(name)) {
    return NULL;
  }
  Dart_NativeFunction result = NULL;
  if (auto_setup_scope == NULL) {
    return NULL;
  }

  Dart_EnterScope();
  const char* cname;
  HandleError(Dart_StringToCString(name, &cname));

  if (strcmp("GV_Layout", cname) == 0) result = GV_Layout;

  Dart_ExitScope();
  return result;
}

