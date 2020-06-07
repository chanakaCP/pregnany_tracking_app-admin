import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/Screens/admin/tips/add/addMainTopic.dart';
import 'package:mama_k_app_admin/Screens/admin/tips/delete/deleteMainTip.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class TipList extends StatelessWidget {
  DatabaseService db = DatabaseService();
  Stream str;

  @override
  Widget build(BuildContext context) {
    str = db.getTipCollection();
    return StreamBuilder<QuerySnapshot>(
      stream: str,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ){
          return Text("waiting for Loadin data");
        } else {
          return ListView(
            scrollDirection: Axis.vertical,
            children: getExpenseItems(snapshot, context),
          );
        }    
      },
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot, BuildContext context) {
    return snapshot.data.docs
        .map(
          (doc) => ListTile(
            title: Text(
              doc["title"],
              style: TextStyle(fontSize: 15.0),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.red[200].withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: Icon(
                      Icons.delete_forever,
                      color: Colors.red[300],
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return DeleteMainTip(doc["id"]);
                      },
                    );
                  },
                ),
                SizedBox(width: 15.0),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.green[200].withOpacity(0.4),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25.0),
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black26,
                    ),
                  ),
                  onTap: () {
                    MainTopic mainTopic = MainTopic();
                    mainTopic.id = doc["id"];
                    mainTopic.title = doc["title"];
                    mainTopic.description = doc["description"];
                    mainTopic.imageURL = doc["imageURL"];
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddMainTopic(mainTopic),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        )
        .toList();
  }
}
