import 'package:bell/connections/all_connections.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme/theme_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        ThemeProvider themeProvider = ThemeProvider();
        themeProvider.loadThemeFromPreferences(); // Load the theme preference
        return themeProvider;
      },
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            theme: themeProvider.isDarkTheme
                ? ThemeData.dark()
                : ThemeData.light(),
            home: AllConnections(),
          );
        },
      ),
    );
  }
}
