import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/bloc.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/dropdown_selector_widget.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/status_widget.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/combined_stop_forecast_widget.dart';

class TramsScreen extends StatefulWidget {
  const TramsScreen({Key? key}) : super(key: key);

  @override
  createState() {
    return TramsScreenState();
  }
}

class TramsScreenState extends State<TramsScreen>
    with TickerProviderStateMixin {
  static const int redLineTabIndex = 0;
  static const int greenLineTabIndex = 1;

  final List<Tab> _homeScreenTabs = const <Tab>[
    Tab(text: "RED LINE"),
    Tab(text: "GREEN LINE"),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(context) {
    final bloc = Provider.of(context)?.bloc;
    final tabController =
        TabController(length: _homeScreenTabs.length, vsync: this);

    tabController.addListener(() {
      onTabChanged(tabController.index, bloc);
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Material(
          color: const Color(Constant.colorLuasPurple),
          child: TabBar(
            controller: tabController,
            labelPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            indicatorColor: const Color(Constant.colorRedLine),
            indicatorWeight: 4.0,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            tabs: _homeScreenTabs,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: _homeScreenTabs.map((Tab tab) {
              final String label = tab.text?.toLowerCase() ?? "";

              // return TramsScreenContent(tab: tab, tabIndex: _tabController.index);

              return Container(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Column(
                  children: [
                    DropdownSelectorWidget(line: tab.text!),
                    const StatusWidget(),
                    CombinedStopForecastWidget(line: tab.text!),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void onTabChanged(int tabIndex, Bloc? bloc) {
    switch (tabIndex) {
      case redLineTabIndex:
        bloc?.dropdownSelectedValueRedLineStream.listen((event) {
          bloc.fetchStopForecast(Constant.redLineStopMap[event]);
        });

        break;

      case greenLineTabIndex:
        bloc?.dropdownSelectedValueGreenLineStream.listen((event) {
          bloc.fetchStopForecast(Constant.greenLineStopMap[event]);
        });

        break;

      default:
        print("Uh oh"); // TODO: Throw proper exception.
    }
  }
}
