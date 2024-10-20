import 'package:flutter/material.dart';

import 'theme/app_bar.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "About"),
      body: Center(
        child: Text("This is the About screen."),
      ),
    );
  }
}
