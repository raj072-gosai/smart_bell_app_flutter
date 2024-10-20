import 'dart:convert';
import 'package:bell/connections/create_connection_dialog.dart';
import 'package:bell/theme/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../settings/app_drawer.dart';
import 'connection_details_page.dart';  // Import the new page

class AllConnections extends StatefulWidget {
  @override
  _AllConnectionsState createState() => _AllConnectionsState();
}

class _AllConnectionsState extends State<AllConnections> {
  List<Map<String, String>> connections = [];

  @override
  void initState() {
    super.initState();
    _loadConnections();
  }

  Future<void> _loadConnections() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> connectionStrings = prefs.getStringList('connections') ?? [];

    setState(() {
      connections = connectionStrings.map((connection) {
        Map<String, dynamic> data = jsonDecode(connection);
        return {
          'name': data['name'] as String,
          'url': data['url'] as String,
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Connections"),
      drawer: AppDrawer(),
      body: Container(
        color: Colors.grey[100], // Set the background color of the ListView
        child: ListView.builder(
          itemCount: connections.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(connections[index]['name'] ?? ''),
                  subtitle: Text(connections[index]['url'] ?? ''),
                  trailing: _buildHorizontalPopupMenu(index),
                  onTap: () {
                    // Navigate to the ConnectionDetailsPage with the selected connection details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConnectionDetailsPage(
                          connectionName: connections[index]['name']!,
                          connectionUrl: connections[index]['url']!,
                        ),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 2, // Space above and below the divider
                  thickness: 1.5, // Thickness of the divider line
                  color: const Color.fromARGB(255, 0, 0, 0), // Color of the divider
                  indent: 16, // Space from the left edge
                  endIndent: 16, // Space from the right edge
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CreateConnectionDialog();
            },
          ).then((_) {
            _loadConnections();
          });
        },
        child: Icon(Icons.add),
        tooltip: 'Add Connection',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    );
  }

  // Custom Horizontal PopupMenu with transparent background
  Widget _buildHorizontalPopupMenu(int index) {
    return PopupMenuButton<String>(
      icon: Container(
        width: 40, // Set a specific width
        height: 50, // Set a specific height
        padding: EdgeInsets.all(8), // Add some padding around the icon
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255), // Set the background color here
          borderRadius: BorderRadius.circular(20), // Optional: rounded corners
        ),
        child: Icon(Icons.more_vert), // Three vertical dots
      ),
      offset: Offset(0, 40), // Adjust position if needed
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.transparent, // Background color for the popup menu
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Space icons evenly
              children: [
                _buildCircularIconButton(Icons.delete, 'delete', index),
                _buildCircularIconButton(Icons.edit, 'edit', index),
                _buildCircularIconButton(Icons.copy, 'copy', index),
                _buildCircularIconButton(Icons.close, 'close', index),
              ],
            ),
          ),
        ];
      },
    );
  }

  // Build circular icon button for each action in the popup menu
  Widget _buildCircularIconButton(IconData icon, String action, int index) {
    return IconButton(
      icon: CircleAvatar(
        backgroundColor: Colors.grey[200], // Light background for icons
        child: Icon(icon, color: Colors.black), // Icon color
      ),
      onPressed: () {
        Navigator.of(context).pop(); // Close the popup menu
        _onMenuSelected(action, index); // Handle the action
      },
    );
  }

  // Handle actions for the popup menu
  void _onMenuSelected(String action, int index) async {
    if (action == 'delete') {
      setState(() {
        connections.removeAt(index);
      });
      final prefs = await SharedPreferences.getInstance();
      List<String> connectionStrings =
          connections.map((conn) => jsonEncode(conn)).toList();
      await prefs.setStringList('connections', connectionStrings);
    } else if (action == 'edit') {
      _showEditDialog(index); // Show the edit dialog
    } else if (action == 'copy') {
      _showCopyDialog(index); // Show the copy dialog
    } else if (action == 'share') {
      // Add your share logic here
      print('Share: ${connections[index]}');
    } else if (action == 'close') {
      // Close logic here
      print('Close: ${connections[index]}');
    }
  }

  // Show a dialog to edit the connection
  void _showEditDialog(int index) {
    final TextEditingController nameController =
        TextEditingController(text: connections[index]['name']);
    final TextEditingController urlController =
        TextEditingController(text: connections[index]['url']);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Connection'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Connection Name',
                  hintText: 'Enter new name for the connection',
                ),
              ),
              TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: 'Connection URL (IP Address)',
                  hintText: 'Enter new URL',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Update the existing connection
                  connections[index] = {
                    'name': nameController.text, // New name
                    'url': urlController.text, // New URL
                  };
                });

                // Save the updated connections to SharedPreferences
                final prefs = SharedPreferences.getInstance();
                List<String> connectionStrings =
                    connections.map((conn) => jsonEncode(conn)).toList();
                prefs.then((prefsInstance) {
                  prefsInstance.setStringList('connections', connectionStrings);
                });

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Show a dialog to copy the connection with a new name
  void _showCopyDialog(int index) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Copy Connection'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'New Connection Name',
              hintText: 'Enter a new name for the copied connection',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  setState(() {
                    // Create a copy of the existing connection
                    Map<String, String> copiedConnection = {
                      'name': nameController.text, // Use new name
                      'url': connections[index]['url'] ?? '',
                    };
                    connections.add(copiedConnection); // Add it to the list
                  });

                  // Save the updated connections to SharedPreferences
                  final prefs = SharedPreferences.getInstance();
                  List<String> connectionStrings =
                      connections.map((conn) => jsonEncode(conn)).toList();
                  prefs.then((prefsInstance) {
                    prefsInstance.setStringList('connections', connectionStrings);
                  });

                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  // Optionally handle empty name input
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a name.')),
                  );
                }
              },
              child: Text('Copy'),
            ),
          ],
        );
      },
    );
  }
}
