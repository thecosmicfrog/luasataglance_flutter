import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/bloc.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/stop_forecast_direction_container_widget.dart';
import 'package:rxdart/rxdart.dart';

class FullStopForecastWidget extends StatelessWidget {
  final String line;
  final _controller = ScrollController();

  FullStopForecastWidget({Key? key, required this.line}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Bloc? bloc = Provider.of(context)?.bloc;

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
              StopForecastDirectionContainerWidget(
                line: line,
                direction: "Inbound",
              ),
              StopForecastDirectionContainerWidget(
                line: line,
                direction: "Outbound",
              ),
            ],
          ),
        ),
        onRefresh: () async {
          return await refresh(bloc);
        },
      ),
    );
  }

  Future<void> refresh(Bloc? bloc) async {
    //////////////////////////////////////////////////////////////////
    // TODO: This is code duplication with TramsScreen.onTabChanged()
    //////////////////////////////////////////////////////////////////
    switch (line) {
      case "RED LINE":
        await for (var stopName in bloc?.dropdownSelectedValueRedLineStream ??
            BehaviorSubject<String>()) {
          return bloc?.fetchStopForecast(Constant.redLineStopMap[stopName]);
        }

        break;

      case "GREEN LINE":
        await for (var stopName in bloc?.dropdownSelectedValueGreenLineStream ??
            BehaviorSubject<String>()) {
          return bloc?.fetchStopForecast(Constant.greenLineStopMap[stopName]);
        }

        break;

      default:
        print("Uh oh"); // TODO: Throw proper exception.
    }
  }
}
