import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class DeleteMonth extends StatefulWidget {
  int month;
  DeleteMonth(this.month);
  @override
  _DeleteMonthState createState() => _DeleteMonthState();
}

class _DeleteMonthState extends State<DeleteMonth> {
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
        _databaseService.deleteMomMonth(this.widget.month);
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete month details ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
