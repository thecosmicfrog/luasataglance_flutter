import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';

//
import 'dart:convert';
//

class StatusWidget extends StatelessWidget {
  const StatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context)?.bloc;

    return StreamBuilder(
      stream: bloc?.stopForecastValueStream,
      builder:
          (BuildContext context, AsyncSnapshot<StopForecastModel> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final String? stopForecastStatusMessage = snapshot.data?.message;

        // print(stopForecastStatusMessage);
        // print(Utf8Decoder()
        //     .convert(stopForecastStatusMessage?.codeUnits as List<int>));

        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Card(
            elevation: 4.0,
            margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 12.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: const Color(Constant.colorStatusOk),
                  child: const Text(
                    "Status",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  stopForecastStatusMessage ?? "No status message available",
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
