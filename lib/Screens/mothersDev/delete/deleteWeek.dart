import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class DeleteWeek extends StatefulWidget {
  int week;
  DeleteWeek(this.week);
  @override
  _DeleteWeekState createState() => _DeleteWeekState();
}

class _DeleteWeekState extends State<DeleteWeek> {
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
        _databaseService.deleteMomWeek(this.widget.week);
        Navigator.of(context).pop();
      },
    );

    return AlertDialog(
      title: Text("Confirm Delete"),
      content: Text("Are you sure you want to delete week details ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}
