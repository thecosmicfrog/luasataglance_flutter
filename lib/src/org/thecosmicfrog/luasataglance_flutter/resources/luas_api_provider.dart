import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';

class LuasApiProvider {
  Client http = Client();

  Future<StopForecastModel> fetchStopForecast(String? stopId) async {
    final response = await http.get(Uri.parse(
        "https://api.thecosmicfrog.org/cgi-bin/luas-api.php?ver=3&action=times&station=$stopId"));
    // final response = await http.get(Uri.parse(
    //     "https://api.thecosmicfrog.org/stag/cgi-bin/luas-api.php?ver=3&action=times&station=MOCK"));
    if (response.statusCode == 200) {
      return StopForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw const HttpException('Failed to retrieve stop forecast.');
    }
  }
}
