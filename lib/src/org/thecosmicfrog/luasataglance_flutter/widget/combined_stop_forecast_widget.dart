import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/stop_forecast_direction_widget.dart';

class CombinedStopForecastWidget extends StatelessWidget {
  final String line;
  final _controller = ScrollController();

  CombinedStopForecastWidget({Key? key, required this.line}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        color: line == "RED LINE"
            ? const Color(Constant.colorRedLine)
            : const Color(Constant.colorGreenLine),
        child: FadingEdgeScrollView.fromScrollView(
          gradientFractionOnStart: 0.2,
          gradientFractionOnEnd: 0.2,
          child: ListView(
            controller: _controller,
            padding: const EdgeInsets.only(bottom: 64.0),
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              StopForecastDirectionWidget(line: line, direction: "Inbound"),
              StopForecastDirectionWidget(line: line, direction: "Outbound"),
            ],
          ),
        ),
        onRefresh: () async {
          print("Refreshed");
        },
      ),
      // child: FadingEdgeScrollView.fromScrollView(
      //   gradientFractionOnStart: 0.2,
      //   gradientFractionOnEnd: 0.2,
      //   child: ListView(
      //     controller: _controller,
      //     padding: const EdgeInsets.only(bottom: 64.0),
      //     children: [
      //       StopForecastDirectionWidget(line: line, direction: "Inbound"),
      //       StopForecastDirectionWidget(line: line, direction: "Outbound"),
      //     ],
      //   ),
      // ),
    );
  }
}
