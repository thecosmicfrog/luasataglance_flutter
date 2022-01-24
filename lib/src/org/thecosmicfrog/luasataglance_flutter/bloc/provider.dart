import 'package:flutter/material.dart';

import 'bloc.dart';

class Provider extends InheritedWidget {
  final Bloc bloc;

  const Provider({Key? key, required Widget child, required this.bloc})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static Provider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }
}
