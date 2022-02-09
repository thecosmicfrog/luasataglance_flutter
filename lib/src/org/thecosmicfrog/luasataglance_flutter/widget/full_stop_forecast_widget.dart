import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/bloc.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/stop_forecast_direction_container_widget.dart';
import 'package:rxdart/rxdart.dart';

class FullStopForecastWidget extends StatelessWidget {
  final String line;
  final _scrollController = ScrollController();

  FullStopForecastWidget({Key? key, required this.line}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Bloc? bloc = Provider.of(context)?.bloc;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(right: 6.0),
        child: RefreshIndicator(
          color: line == Constant.redLine.toUpperCase()
              ? const Color(Constant.colorRedLine)
              : const Color(Constant.colorGreenLine),
          child: RawScrollbar(
            controller: _scrollController,
            thumbColor: const Color(Constant.colorSlightGrey),
            radius: const Radius.circular(20.0),
            child: ListView(
              controller: _scrollController,
              padding:
                  const EdgeInsets.only(left: 12.0, right: 6.0),
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
