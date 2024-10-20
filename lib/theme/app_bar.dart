import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    
    return Theme(
      data: ThemeData(
        primaryColor: Colors.blue, // Change this to customize the AppBar color
        appBarTheme: AppBarTheme(
          color: Colors.blueAccent, // Background color of the AppBar
          elevation: 2.0, // Elevation of the AppBar
          titleTextStyle: TextStyle(
            color: Colors.white, // Title text color
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Icon color
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.white, // Action icons color
          ),
        ),
      ),
      child: AppBar(
        title: Text(title),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
