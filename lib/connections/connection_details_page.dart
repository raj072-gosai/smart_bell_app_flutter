import 'package:flutter/material.dart';

import '../settings/app_drawer.dart'; // Import the AppDrawer widget

class ConnectionDetailsPage extends StatelessWidget {
  final String connectionName;
  final String connectionUrl;

  ConnectionDetailsPage(
      {required this.connectionName, required this.connectionUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(connectionName),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu), // Replace back button with menu button
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
            );
          },
        ),
      ),
      drawer: AppDrawer(), // Add the AppDrawer to the Scaffold
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connection Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(connectionName),
            SizedBox(height: 16),
            Text(
              'Connection URL:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(connectionUrl),
          ],
        ),
      ),
    );
  }
}
