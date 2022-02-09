import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/bloc.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/model/stop_forecast_model.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/resources/constant.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/dropdown_selector_widget.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/status_widget.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/full_stop_forecast_widget.dart';

class TramsScreen extends StatefulWidget {
  const TramsScreen({Key? key}) : super(key: key);

  @override
  createState() => TramsScreenState();
}

class TramsScreenState extends State<TramsScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  static const int redLineTabIndex = 0;
  static const int greenLineTabIndex = 1;

  final List<Tab> _homeScreenTabs = <Tab>[
    Tab(text: Constant.redLine.toUpperCase()),
    Tab(text: Constant.greenLine.toUpperCase()),
  ];

  @override
  void initState() {
    super.initState();
  }

  /* Don't unload tab content when tab is switched. Prevents UI stutters. */
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(context) {
    super.build(context);

    final bloc = Provider.of(context)?.bloc;
    final tabController =
        TabController(length: _homeScreenTabs.length, vsync: this);

    tabController.addListener(() {
      if (tabController.indexIsChanging ||
          (tabController.animation?.value == tabController.index)) {
        onTabChanged(tabController.index, bloc);
      }
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StreamBuilder(
          stream: bloc?.currentlySelectedTabStream,
          initialData: Constant.redLine,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }

            String? currentlySelectedTab = snapshot.data;

            return Material(
              color: const Color(Constant.colorLuasPurple),
              child: TabBar(
                controller: tabController,
                labelPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                indicatorColor: Color(
                  currentlySelectedTab == Constant.redLine
                      ? Constant.colorRedLine
                      : Constant.colorGreenLine,
                ),
                indicatorWeight: 4.0,
                labelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
                tabs: _homeScreenTabs,
              ),
            );
          },
        ),
        StreamBuilder(
            stream: bloc?.stopForecastValueStream,
            builder: (BuildContext context,
                AsyncSnapshot<StopForecastModel> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              if (snapshot.data?.clear ?? false) {
                return Container(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: const LinearProgressIndicator(
                    color: Color(Constant.colorLuasPurple),
                    backgroundColor: Color(Constant.colorLuasPurpleFaded),
                  ),
                );
              }

              return Container(
                padding: const EdgeInsets.only(top: 12.0),
              );
            }),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: _homeScreenTabs.map((Tab tab) {
              final String label = tab.text?.toLowerCase() ?? "";

              return Column(
                children: [
                  DropdownSelectorWidget(line: tab.text!),
                  const StatusWidget(),
                  FullStopForecastWidget(line: tab.text!),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  /// When tab is changed, load a new stop forecast.
  void onTabChanged(int tabIndex, Bloc? bloc) {
    switch (tabIndex) {
      case redLineTabIndex:
        bloc?.currentlySelectedTabSink(Constant.redLine);

        bloc?.dropdownSelectedValueRedLineStream.listen((event) {
          bloc.fetchStopForecast(Constant.redLineStopMap[event]);
        });

        break;

      case greenLineTabIndex:
        bloc?.currentlySelectedTabSink(Constant.greenLine);

        bloc?.dropdownSelectedValueGreenLineStream.listen((event) {
          bloc.fetchStopForecast(Constant.greenLineStopMap[event]);
        });

        break;

      default:
        print("Uh oh"); // TODO: Throw proper exception.
    }
  }
}
