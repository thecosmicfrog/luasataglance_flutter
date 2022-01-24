import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/bloc.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/screen/alerts_screen.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/screen/favourites_screen.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/screen/trams_screen.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/screen/map_screen.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/widget/luas_bottom_navigation_bar.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  final int colorLuasPurple = 0xff4d3475;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context)?.bloc;

    return MaterialApp(
        title: "Luas at a Glance",
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(colorLuasPurple),
            elevation: 0.0,
            toolbarHeight: 0.0,
          ),
          backgroundColor: const Color(0xfff5f5f5),
          body: StreamBuilder<NavBarItem>(
            stream: bloc?.itemStream,
            initialData: bloc?.defaultItem,
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }

              switch (snapshot.data) {
                case NavBarItem.trams:
                  return const TramsScreen();

                case NavBarItem.favourites:
                  return const FavouritesScreen();

                case NavBarItem.map:
                  return const MapScreen();

                case NavBarItem.alerts:
                  return const AlertsScreen();

                default:
                  return const TramsScreen();
              }
            },
          ),
          bottomNavigationBar: const LuasBottomNavigationBar(),
        ),
        theme: ThemeData(
          /*
           * Make touch "splash" effect look more native:
           * https://github.com/flutter/flutter/issues/43515#issuecomment-612782673
           */
          splashFactory: InkRipple.splashFactory,
          highlightColor: Colors.transparent,
          splashColor: const Color(0x40CCCCCC).withOpacity(.1),
        ));
  }
}
