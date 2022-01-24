import 'dart:async';

import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/luas_api_provider.dart';
import 'package:rxdart/rxdart.dart';

enum NavBarItem { trams, favourites, map, alerts }

class Bloc {
  final _luasApi = LuasApiProvider();

  final _dropdownSelectedValue = BehaviorSubject<String>.seeded("Abbey Street");
  Stream<String> get dropdownSelectedValueStream =>
      _dropdownSelectedValue.stream;
  Function(String) get dropdownSelectedValueSink =>
      _dropdownSelectedValue.sink.add;

  final _dropdownAllValues =
      BehaviorSubject<List<String>>.seeded(Constant.stopMap.keys.toList());
  Stream<List<String>> get dropdownAllValuesStream => _dropdownAllValues.stream;

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

  fetchStopForecast(String? stopId) async {
    final stopForecast = await _luasApi.fetchStopForecast(stopId);
    _stopForecastValue.sink.add(stopForecast);
  }

  dispose() {
    _dropdownSelectedValue.close();
    _dropdownAllValues.close();
    _stopForecastValue.close();
    _navBarController.close();
  }
}
