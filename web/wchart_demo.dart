import 'dart:html';
import 'dart:async';
import 'package:html_toolbox/widgets_charts.dart';

/**
 * Learn about the Web UI package by visiting
 * http://www.dartlang.org/articles/dart-web-components/.
 */
void main() {
  // Enable this to use Shadow DOM in the browser.
  //useShadowDom = true;
  // xtag is null until the end of the event loop (known dart web ui issue)
  new Timer(const Duration(), () {
    var cnt = 0;
    const interval = 1000 ~/ 30;
    const duration = 2000 / interval;
    var values = new List<double>(2);
    var chart = new ChartT()
    ..el = querySelector("#chart_demo0")
    ;
    new Timer.periodic(const Duration(milliseconds: interval), (timer) {
      //var v0 = random.nextDouble() * 100.0;
      cnt = (cnt + 1) % duration;
      values[0] = inQuad(cnt/duration, chart.ymax, chart.ymin );
      values[1] = outCubic(cnt/duration, chart.ymax, chart.ymin );
      chart.push(values);
    });
  });
}

// copy from dartemis_toolbox/ease.dart
num inQuad(double ratio, num change, num baseValue) {
  return change * ratio * ratio + baseValue;
}

num outCubic(double ratio, num change, num baseValue) {
  ratio--;
  return change * (ratio * ratio * ratio + 1) + baseValue;
}