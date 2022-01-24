import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/bloc.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';

class LuasBottomNavigationBar extends StatelessWidget {
  const LuasBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context)?.bloc;

    return StreamBuilder(
        stream: bloc?.itemStream,
        initialData: bloc?.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xff4d3475),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: snapshot.data?.index ?? 0,
            onTap: bloc?.pickItem,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.tram), label: "Trams"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star), label: "Favourites"),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: "Luas Map",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.error), label: "Alerts")
            ],
          );
        });
  }
}
