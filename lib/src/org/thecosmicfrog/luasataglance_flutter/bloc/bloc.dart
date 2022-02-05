import 'dart:async';

import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/luas_api_provider.dart';
import 'package:rxdart/rxdart.dart';

enum NavBarItem { trams, favourites, map, alerts }

class Bloc {
  final _luasApi = LuasApiProvider();

  final _dropdownSelectedValueRedLine =
      BehaviorSubject<String>.seeded("Select a stop..."); // TODO: Urgh...
  Stream<String> get dropdownSelectedValueRedLineStream =>
      _dropdownSelectedValueRedLine.stream;
  Function(String) get dropdownSelectedValueRedLineSink =>
      _dropdownSelectedValueRedLine.sink.add;

  final _dropdownSelectedValueGreenLine =
      BehaviorSubject<String>.seeded("Select a stop..."); // TODO: Urgh...
  Stream<String> get dropdownSelectedValueGreenLineStream =>
      _dropdownSelectedValueGreenLine.stream;
  Function(String) get dropdownSelectedValueGreenLineSink =>
      _dropdownSelectedValueGreenLine.sink.add;

  final _dropdownAllValuesRedLine = BehaviorSubject<List<String>>.seeded(
      Constant.redLineStopMap.keys.toList());
  Stream<List<String>> get dropdownAllValuesRedLineStream =>
      _dropdownAllValuesRedLine.stream;

  final _dropdownAllValuesGreenLine = BehaviorSubject<List<String>>.seeded(
      Constant.greenLineStopMap.keys.toList());
  Stream<List<String>> get dropdownAllValuesGreenLineStream =>
      _dropdownAllValuesGreenLine.stream;

  final _stopForecastValue = BehaviorSubject<StopForecastModel>();
  Stream<StopForecastModel> get stopForecastValueStream =>
      _stopForecastValue.stream;
  Function(StopForecastModel) get stopForecastValueSink =>
      _stopForecastValue.sink.add;

  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();
  Stream<NavBarItem> get itemStream => _navBarController.stream;
  NavBarItem defaultItem = NavBarItem.trams;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.trams);
        break;

      case 1:
        _navBarController.sink.add(NavBarItem.favourites);
        break;

      case 2:
        _navBarController.sink.add(NavBarItem.map);
        break;

      case 3:
        _navBarController.sink.add(NavBarItem.alerts);
        break;
    }
  }

  Future<void> fetchStopForecast(String? stopId) async {
    /*
     * Before fetching a new stop forecast, clear the existing stop forecast by
     * sending a special "clear" model to the stream.
     */
    _stopForecastValue.sink.add(StopForecastModel(clear: true));

    final stopForecast = await _luasApi.fetchStopForecast(stopId);
    _stopForecastValue.sink.add(stopForecast);
  }

  dispose() {
    _dropdownSelectedValueRedLine.close();
    _dropdownAllValuesRedLine.close();
    _stopForecastValue.close();
    _navBarController.close();
  }
}
