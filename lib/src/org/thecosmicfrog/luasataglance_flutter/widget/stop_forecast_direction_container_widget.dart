import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/stop_forecast_entries_widget.dart';

class StopForecastDirectionContainerWidget extends StatelessWidget {
  final String line;
  final String direction;

  const StopForecastDirectionContainerWidget(
      {Key? key, required this.direction, required this.line})
      : super(key: key);

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

          return SizedBox(
            width: double.infinity,
            child: Card(
              color: const Color(Constant.colorLuasPurple),
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text(
                      direction.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  StopForecastEntriesWidget(
                    direction: direction,
                  )
                ],
              ),
            ),
          );
        });
  }
}
