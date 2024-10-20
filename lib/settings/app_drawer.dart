import 'package:bell/connections/all_connections.dart'; // Import the AllConnections page
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../about.dart';
import '../backup_restore.dart';
import '../guide/user_guide.dart';
import '../help_faq.dart';
import 'app_settings.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.wifi,
                  size: 60,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  'My App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.wifi),
            title: Text('All Connections'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              // Navigate back to AllConnections page if not already there
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AllConnections()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('App Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.backup),
            title: Text('Backup and Restore'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BackupRestore()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help and FAQ'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpFaq()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('User Guide'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserGuide()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              SystemNavigator.pop(); // This will close the app
            },
          ),
        ],
      ),
    );
  }
}
