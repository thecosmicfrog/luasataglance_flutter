import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/dropdown_selector_widget.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/message_widget.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/combined_stop_forecast_widget.dart';

class TramsScreen extends StatelessWidget {
  const TramsScreen({Key? key}) : super(key: key);

  final int colorLuasPurple = 0xff4d3475;

  final List<Tab> _homeScreenTabs = const <Tab>[
    Tab(text: "RED LINE"),
    Tab(text: "GREEN LINE"),
  ];

  @override
  Widget build(context) {
    return DefaultTabController(
        length: _homeScreenTabs.length,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Material(
              color: Color(colorLuasPurple),
              child: TabBar(
                indicatorColor: Colors.red,
                labelColor: Colors.white,
                tabs: _homeScreenTabs,
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _homeScreenTabs.map((Tab tab) {
                  final String label = tab.text?.toLowerCase() ?? "";

                  return Container(
                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                    child: Column(children: [
                      const DropdownSelectorWidget(),
                      const MessageWidget(),
                      CombinedStopForecastWidget(),
                    ]),
                  );
                }).toList(),
              ),
            ),
          ],
        ));
  }
}
