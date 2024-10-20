import 'package:flutter/material.dart';
import 'theme/app_bar.dart';

class BackupRestore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Backup and Restore"),
      body: Center(
        child: Text("This is the Backup and Restore screen."),
      ),
    );
  }
}
