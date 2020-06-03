import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/admin/babysDev/babyDevAdd.dart';
import 'package:mama_k_app_admin/Screens/admin/babysDev/deleteBabyWeek.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';

class BabysDev extends StatefulWidget {
  @override
  _BabysDevState createState() => _BabysDevState();
}

class _BabysDevState extends State<BabysDev> {
  Future userStream;
  Baby babyWeek = Baby();

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
                        "Baby's development - Weekly",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 50.0),
                Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height * 0.22,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 40,
                        itemBuilder: (context, position) {
                          return buildListItem(position + 1);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildListItem(int week) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.only(left: 20.0, right: 10.0, top: 17.0, bottom: 17.0),
        decoration: BoxDecoration(
          color: Colors.lightGreen[100].withOpacity(0.7),
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 175.0,
              child: Row(
                children: <Widget>[
                  Text(
                    "Week " + (week).toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18.0,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  // Icon(
                  //   (allSet) ? Icons.done_all : Icons.close,
                  //   color: (allSet) ? Colors.blue[500] : Colors.red[300],
                  // ),
                ],
              ),
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(right: 1.0),
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
                    return DeleteBabyWeek(week);
                  },
                );
              },
            ),
            SizedBox(width: 20.0),
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
                  Icons.arrow_forward_ios,
                  color: Colors.black26,
                ),
              ),
              onTap: () {       
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BabyDevAdd(week),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
