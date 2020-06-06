import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class DeleteMainTip extends StatefulWidget {
  String id;
  DeleteMainTip(this.id);
  @override
  _DeleteMainTipState createState() => _DeleteMainTipState();
}

class _DeleteMainTipState extends State<DeleteMainTip> {
  DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("DELETE"),
      onPressed: () {
        _databaseService.deleteMainTopic(this.widget.id);
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete this ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}