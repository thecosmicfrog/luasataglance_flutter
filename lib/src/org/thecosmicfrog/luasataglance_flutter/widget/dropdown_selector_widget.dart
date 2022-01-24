import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';

class DropdownSelectorWidget extends StatelessWidget {
  const DropdownSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context)?.bloc;

    return StreamBuilder(
        stream: bloc?.dropdownSelectedValueStream,
        builder: (BuildContext context,
            AsyncSnapshot<String> dropdownSelectedValueSnapshot) {
          if (!dropdownSelectedValueSnapshot.hasData) {
            print("dropdownSelectedValueSnapshot has no data");
            return Container();
          }

          print("dropdownSelectedValueSnapshot has data: "
              "${dropdownSelectedValueSnapshot.data}");

          return StreamBuilder(
              stream: bloc?.dropdownAllValuesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<List<String>> dropdownAllValuesSnapshot) {
                if (!dropdownAllValuesSnapshot.hasData) {
                  print("dropdownAllValuesSnapshot has no data");
                } else {
                  print("dropdownAllValuesSnapshot has data: "
                      "${dropdownAllValuesSnapshot.data.toString()}");

                  return SizedBox(
                      width: double.infinity,
                      child: Card(
                          elevation: 4.0,
                          margin: const EdgeInsets.only(
                              left: 4.0, right: 4.0, top: 16.0, bottom: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              borderRadius: BorderRadius.circular(12),
                              value: dropdownSelectedValueSnapshot.data,
                              items: dropdownAllValuesSnapshot.data
                                  ?.map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(value),
                                    ));
                              }).toList(),
                              onChanged: ((String? newValue) async {
                                final stopCode = Constant.stopMap[newValue];
                                final stopForecast =
                                    bloc?.fetchStopForecast(stopCode);
                                print(stopForecast);
                                bloc?.dropdownSelectedValueSink(newValue!);
                              }),
                            ),
                          )));
                }

                return Container();
              });
        });
  }
}
