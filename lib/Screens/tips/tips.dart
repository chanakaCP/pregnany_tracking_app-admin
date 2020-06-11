import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/tips/add/addMainTopic.dart';
import 'package:mama_k_app_admin/Screens/tips/tipList.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        margin: EdgeInsets.only(right: 1.0),
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.green[200].withOpacity(0.4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25.0),
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black26,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      child: Text(
                        "Tips ",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                        ),
                        child: Text(
                          "Add New",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: Colors.green[900],
                          ),
                        ),
                      ),
                      onTap: () {
                        MainTopic mainTopic = MainTopic();
                        mainTopic.id = _databaseService.randomIdForMain();
                        mainTopic.title = "";
                        mainTopic.description = "";
                        mainTopic.imageURL = "";
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
                SizedBox(height: 20.0),
                Container(
                  child: TipList(),
                  height: 500.0,
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
