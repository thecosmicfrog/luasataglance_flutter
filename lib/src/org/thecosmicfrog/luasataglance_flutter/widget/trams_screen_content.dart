// import 'package:flutter/material.dart';
// import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
// import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
//
// import 'combined_stop_forecast_widget.dart';
// import 'dropdown_selector_widget.dart';
// import 'status_widget.dart';
//
// class TramsScreenContent extends StatelessWidget {
//   static const int redLineTabIndex = 0;
//   static const int greenLineTabIndex = 1;
//
//   Tab tab;
//   int tabIndex;
//
//   TramsScreenContent({Key? key, required this.tab, required this.tabIndex}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = Provider.of(context)?.bloc;
//
//     switch (tabIndex) {
//       case redLineTabIndex:
//         print("red");
//         bloc?.dropdownSelectedValueRedLineStream.listen((event) {
//           bloc.fetchStopForecast(Constant.redLineStopMap[event]);
//         });
//
//         break;
//
//       case greenLineTabIndex:
//         print("green");
//         bloc?.dropdownSelectedValueGreenLineStream.listen((event) {
//           bloc.fetchStopForecast(Constant.greenLineStopMap[event]);
//         });
//
//         break;
//
//       default:
//         print("Uh oh"); // TODO: Throw proper exception.
//     }
//
//     return Container(
//       padding: const EdgeInsets.only(left: 12.0, right: 12.0),
//       child: Column(children: [
//         DropdownSelectorWidget(line: tab.text!),
//         const MessageWidget(),
//         CombinedStopForecastWidget(line: tab.text!),
//       ]),
//     );
//   }
// }
