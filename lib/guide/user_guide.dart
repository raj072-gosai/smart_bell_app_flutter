import 'package:flutter/material.dart';
import '../theme/app_bar.dart';

class UserGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "User Guide"),
      body: Center(
        child: Text("This is the user guide screen."),
      ),
    );
  }
}
