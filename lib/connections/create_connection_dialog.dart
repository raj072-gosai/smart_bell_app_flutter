import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateConnectionDialog extends StatefulWidget {
  final Map<String, String>? connection; // Add this to pass connection data

  CreateConnectionDialog({this.connection});

  @override
  _CreateConnectionDialogState createState() => _CreateConnectionDialogState();
}

class _CreateConnectionDialogState extends State<CreateConnectionDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.connection != null) {
      // If editing, populate fields with existing data
      nameController.text = widget.connection!['name'] ?? '';
      urlController.text = widget.connection!['url'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.connection != null ? 'Edit Connection' : 'New Connection'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: urlController,
            decoration: InputDecoration(labelText: 'URL'),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            final newConnection = {
              'name': nameController.text,
              'url': urlController.text,
            };

            List<String> connectionStrings = prefs.getStringList('connections') ?? [];

            if (widget.connection == null) {
              // New connection
              connectionStrings.add(jsonEncode(newConnection));
            } else {
              // Editing an existing connection
              final index = connectionStrings.indexOf(jsonEncode(widget.connection));
              connectionStrings[index] = jsonEncode(newConnection);
            }

            await prefs.setStringList('connections', connectionStrings);

            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
