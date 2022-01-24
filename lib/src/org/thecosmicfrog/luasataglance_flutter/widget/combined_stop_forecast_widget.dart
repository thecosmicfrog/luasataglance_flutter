import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/stop_forecast_direction_widget.dart';

class CombinedStopForecastWidget extends StatelessWidget {
  CombinedStopForecastWidget({Key? key}) : super(key: key);

  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FadingEdgeScrollView.fromScrollView(
            gradientFractionOnStart: 0.2,
            gradientFractionOnEnd: 0.2,
            child: ListView(
              controller: _controller,
              padding: const EdgeInsets.only(bottom: 64.0),
              children: const [
                StopForecastDirectionWidget(direction: "Inbound"),
                StopForecastDirectionWidget(direction: "Outbound")
              ],
            )));
  }
}
