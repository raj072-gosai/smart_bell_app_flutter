import 'package:flutter/material.dart';
import 'theme/app_bar.dart';

class HelpFaq extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "help faq"),
      body: Center(
        child: Text("This is the help faq screen."),
      ),
    );
  }
}
