import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';

class DropdownSelectorWidget extends StatelessWidget {
  final String line;

  const DropdownSelectorWidget({Key? key, required this.line})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context)?.bloc;
    late final Map<String, String> stopMap;
    late final Stream<List<String>>? dropdownAllValuesStream;
    late final Stream<String>? dropdownSelectedValueStream;
    late final Function(String value)? dropdownSelectedValueSink;

    switch (line) {
      case "RED LINE":
        stopMap = Constant.redLineStopMap;
        dropdownAllValuesStream = bloc?.dropdownAllValuesRedLineStream;
        dropdownSelectedValueStream = bloc?.dropdownSelectedValueRedLineStream;
        dropdownSelectedValueSink = bloc?.dropdownSelectedValueRedLineSink;

        break;

      case "GREEN LINE":
        stopMap = Constant.greenLineStopMap;
        dropdownAllValuesStream = bloc?.dropdownAllValuesGreenLineStream;
        dropdownSelectedValueStream =
            bloc?.dropdownSelectedValueGreenLineStream;
        dropdownSelectedValueSink = bloc?.dropdownSelectedValueGreenLineSink;

        break;

      default:
        // TODO: Proper exception handling.
        print("Something has gone terribly wrong.");
    }

    return StreamBuilder(
      stream: dropdownSelectedValueStream,
      builder: (BuildContext context,
          AsyncSnapshot<String> dropdownSelectedValueSnapshot) {
        if (!dropdownSelectedValueSnapshot.hasData) {
          return Container();
        }

        final String? dropdownSelectedStop = dropdownSelectedValueSnapshot.data;

        /*
         * If the dropdown value is "Select a stop...", just clear the stop
         * forecast to avoid any confusion.
         */
        if (dropdownSelectedStop == "Select a stop...") {
          bloc?.stopForecastValueSink(StopForecastModel(clear: true));
        }

        return StreamBuilder(
          stream: dropdownAllValuesStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<String>> dropdownAllValuesSnapshot) {
            if (!dropdownAllValuesSnapshot.hasData) {
              return Container();
            }

            return Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
              child: Card(
                elevation: 4.0,
                margin: const EdgeInsets.only(
                  left: 4.0,
                  right: 4.0,
                  top: 10.0,
                  bottom: 16.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: SizedBox(
                    height: 60.0,
                    child: ButtonTheme(
                      alignedDropdown: true,
                      child: DropdownButton(
                        isExpanded: true,
                        itemHeight: 56.0,
                        iconSize: 38.0,
                        iconEnabledColor: const Color(Constant.colorLuasPurple),
                        menuMaxHeight: 500.0,
                        borderRadius: BorderRadius.circular(12),
                        value: dropdownSelectedStop,
                        items: dropdownAllValuesSnapshot.data
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 25.0),
                            ),
                          );
                        }).toList(),
                        onChanged: ((String? newValue) async {
                          final stopCode = stopMap[newValue];
                          final stopForecast =
                              bloc?.fetchStopForecast(stopCode);
                          dropdownSelectedValueSink!(newValue!);
                        }),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
