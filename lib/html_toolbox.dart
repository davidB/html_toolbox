// License [CC0](http://creativecommons.org/publicdomain/zero/1.0/)
library html_toolbox;

import 'dart:html';
import 'dart:async';

part 'html_toolbox/micro_template.dart';

String findBaseUrl() {
  String location = window.location.pathname;
  int slashIndex = location.lastIndexOf('/');
  if (slashIndex < 0) {
    return '/';
  } else {
    return location.substring(0, slashIndex);
  }
}

Iterable<Future<Element>> loadDataSvgs(){
  return document.querySelectorAll("[data-svg-src]").map((el){
    var src = el.dataset["svgSrc"];
    return HttpRequest.request(src, responseType : 'document').then((httpRequest){
      var doc = httpRequest.responseXml;
      var child = doc.documentElement.clone(true);
      // to fill parent el and keep original ratio of the image
      child.attributes.remove("width");
      child.attributes.remove("height");
      child.style.width = "100%";
      child.style.height = "100%";
      el.append(child);
      return child;
    });
  }).toList(growable: false); // to list is called to force execution of the map function (the function map() is lazy in Dart)
}
