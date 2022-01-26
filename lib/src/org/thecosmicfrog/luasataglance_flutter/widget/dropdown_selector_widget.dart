import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
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
        print("Something has gone terribly wrong.");
    }

    return StreamBuilder(
      stream: dropdownSelectedValueStream,
      builder: (BuildContext context,
          AsyncSnapshot<String> dropdownSelectedValueSnapshot) {
        if (!dropdownSelectedValueSnapshot.hasData) {
          print("dropdownSelectedValueSnapshot has no data");
          return Container();
        }

        print("dropdownSelectedValueSnapshot has data: "
            "${dropdownSelectedValueSnapshot.data}");

        return StreamBuilder(
          stream: dropdownAllValuesStream,
          builder: (BuildContext context,
              AsyncSnapshot<List<String>> dropdownAllValuesSnapshot) {
            if (!dropdownAllValuesSnapshot.hasData) {
              print("dropdownAllValuesSnapshot has no data");
            } else {
              // print("dropdownAllValuesSnapshot has data: "
              //     "${dropdownAllValuesSnapshot.data.toString()}");

              return SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.only(
                    left: 4.0,
                    right: 4.0,
                    top: 16.0,
                    bottom: 16.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: SizedBox(
                      height: 60.0,
                      child: DropdownButton(
                        isExpanded: true,
                        borderRadius: BorderRadius.circular(12),
                        value: dropdownSelectedValueSnapshot.data,
                        items: dropdownAllValuesSnapshot.data
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 25.0),
                              ),
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
              );
            }

            return Container();
          },
        );
      },
    );
  }
}
