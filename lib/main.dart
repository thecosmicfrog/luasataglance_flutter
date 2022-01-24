import 'package:flutter/material.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/bloc.dart';
import 'package:luasataglance_flutter/src/org/thecosmicfrog/luasataglance_flutter/bloc/provider.dart';

import 'src/org/thecosmicfrog/app.dart';

void main() {
  runApp(Provider(bloc: Bloc(), child: const App()));
}
