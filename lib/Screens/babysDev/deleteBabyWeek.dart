import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class DeleteBabyWeek extends StatefulWidget {
  int week;
  DeleteBabyWeek(this.week);
  @override
  _DeleteBabyWeekState createState() => _DeleteBabyWeekState();
}

class _DeleteBabyWeekState extends State<DeleteBabyWeek> {
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
        _databaseService.deleteBabyWeek(this.widget.week);
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

