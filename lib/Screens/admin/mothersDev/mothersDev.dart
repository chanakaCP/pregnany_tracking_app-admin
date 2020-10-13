import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/admin/mothersDev/add/addMonth.dart';
import 'package:mama_k_app_admin/Screens/admin/mothersDev/add/addWeek.dart';
import 'package:mama_k_app_admin/Screens/admin/mothersDev/delete/deleteMonth.dart';
import 'package:mama_k_app_admin/Screens/admin/mothersDev/delete/deleteWeek.dart';

class MothersDev extends StatefulWidget {
  @override
  _MothersDevState createState() => _MothersDevState();
}

class _MothersDevState extends State<MothersDev> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  // padding: EdgeInsets.only(top: 25.0, left: 30.0, right: 30.0),
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            child: Container(
                              margin: EdgeInsets.only(left: 30.0, top: 25.0),
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
                            margin: EdgeInsets.only(right: 30.0, top: 25.0),
                            child: Text(
                              "Mother's development ",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        // color: Colors.green[50],
                        height: 40.0,
                        width: double.infinity,
                        child: TabBar(
                          unselectedLabelColor: Colors.black,
                          labelColor: Colors.green,
                          indicatorColor: Colors.green,
                          indicatorWeight: 3.0,
                          controller: _tabController,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          labelPadding: EdgeInsets.symmetric(horizontal: 60.0),
                          tabs: [
                            Tab(
                              child: Text(
                                "Weekly",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Monthly",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 20.0),
                    ],
                  ),
                ),
                Container(
                  height: 500.0,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildList("weekly"),
                      buildList("monthly"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildList(String type) {
    int itemCount;
    String categoryName;
    if (type == "weekly") {
      itemCount = 40;
      categoryName = "Week ";
    } else if (type == "monthly") {
      itemCount = 10;
      categoryName = "Month ";
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.22,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, position) {
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
                          categoryName + (position + 1).toString(),
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
                          return (type == "weekly")
                              ? DeleteWeek(position + 1)
                              : DeleteMonth(position + 1);
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
                          builder: (context) =>
                              (type == "weekly") ? AddWeek(position + 1) : AddMonth(position + 1),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
