import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';

class StopForecastWidget extends StatelessWidget {
  final String direction;
  final stopForecastEntries = <Card>[];

  StopForecastWidget({Key? key, required this.direction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context)?.bloc;

    return StreamBuilder(
        stream: bloc?.stopForecastValueStream,
        builder:
            (BuildContext context, AsyncSnapshot<StopForecastModel> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          final StopForecastModel? stopForecast = snapshot.data;

          if (stopForecast?.trams != null) {

            /* Check if any trams are running in this direction. */
            bool? hasTramsInThisDirection =
                stopForecast?.trams?.any((tram) => tram.direction == direction);

            /*
             * If no trams are running in this direction, display a
             * "No trams forecast..." card.
             */
            if (!hasTramsInThisDirection!) {
              stopForecastEntries.add(
                _buildStopForecastCard(
                  tram: null,
                  canScheduleNotification: false,
                  minOrMins: null,
                ),
              );
            }

            /*
             * Add cards for all trams in this direction. This might be zero, in
             * which case only the "No trams forecast..." card (created above)
             * will be displayed.
             */
            for (Tram tram in stopForecast?.trams ?? <Tram>[]) {
              if (tram.direction == direction) {
                String minOrMins;
                if (tram.dueMinutes == "DUE" || tram.dueMinutes == "") {
                  minOrMins = "";
                } else if (tram.dueMinutes == "1") {
                  minOrMins = "min";
                } else {
                  minOrMins = "mins";
                }

                final bool canScheduleNotification =
                    (tram.dueMinutes != "DUE" &&
                        int.parse(tram.dueMinutes ?? "0") > 3);

                stopForecastEntries.add(
                  _buildStopForecastCard(
                    tram: tram,
                    canScheduleNotification: canScheduleNotification,
                    minOrMins: minOrMins,
                  ),
                );
              }
            }
          }

          return Card(
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            color: const Color(Constant.colorLuasPurple),
            child: Column(
              children: stopForecastEntries,
            ),
          );
        });
  }

  Card _buildStopForecastCard(
      {Tram? tram, required bool canScheduleNotification, String? minOrMins}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          tram?.destination ?? "No trams forecast",
          style: tram == null
              ? const TextStyle(fontWeight: FontWeight.bold)
              : const TextStyle(fontWeight: FontWeight.normal),
        ),
        subtitle:
            canScheduleNotification ? const Text("Tap to set reminder") : null,
        trailing:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            tram?.dueMinutes ?? "",
            style: const TextStyle(fontSize: 18.0),
          ),
          Visibility(
            child: Text(minOrMins ?? ""),
            visible: tram?.dueMinutes == "DUE" ? false : true,
          ),
        ]),
        tileColor: Colors.transparent,
      ),
    );
  }
}
