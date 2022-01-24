import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/stop_forecast_widget.dart';

class StopForecastDirectionWidget extends StatelessWidget {
  final String direction;
  final int colorLuasPurple = 0xff4d3475;

  const StopForecastDirectionWidget({Key? key, required this.direction})
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
              color: Color(colorLuasPurple),
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
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  StopForecastWidget(direction: direction)
                ],
              ),
            ),
          );
        });
  }
}
