// Within your settings screen where the toggle button is located
import 'package:bell/theme/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar:CustomAppBar(title: "Settings"),
      body: 
         SwitchListTile(
          title: Text("Dark Theme"),
          value: themeProvider.isDarkTheme,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
        ),
      
    );
  }
}
