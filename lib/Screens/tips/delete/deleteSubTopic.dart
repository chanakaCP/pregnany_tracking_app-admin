import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class DeleteSubTopic extends StatefulWidget {
  String mainTopicId;
  String subTopicId;
  DeleteSubTopic(this.mainTopicId, this.subTopicId);
  @override
  _DeleteSubTopicState createState() => _DeleteSubTopicState();
}

class _DeleteSubTopicState extends State<DeleteSubTopic> {
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
        _databaseService.deleteSubTopic(this.widget.mainTopicId, this.widget.subTopicId);
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
