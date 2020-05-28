import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/models/motherMonthModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';
// import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';

class AddMonth extends StatefulWidget {
  int month;
  AddMonth(this.month);
  @override
  _AddMonthState createState() => _AddMonthState();
}

class _AddMonthState extends State<AddMonth> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService _databaseService = DatabaseService();
  Stream userStream;
  MotherInMonth motherMonth = MotherInMonth();

  @override
  void initState() {
    super.initState();
    userStream = _databaseService.getBabyWeekForAdmin(this.widget.month);
  }

  @override
  Widget build(BuildContext context) {
    motherMonth.month = this.widget.month;
    return StreamBuilder(
      stream: userStream,
      builder: (context, currentStream) {
        if (currentStream.hasData) {
          print("1");
          // motherMonth.imageURL = currentStream.data["imageURL"];
        } else {
          print("2");
        }
        print("3");
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
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
                          width: 150.0,
                          child: Text(
                            "Mom's Monthly development",
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 18.0,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            "Month " + this.widget.month.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.0,
                              color: Colors.green[900],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100.0),
                    Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                initialValue: motherMonth.imageURL,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                  ),
                                  prefixIcon: Icon(Icons.keyboard),
                                  hintText: "Image ",
                                  filled: true,
                                  fillColor: Colors.green[50],
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    this.motherMonth.imageURL = value;
                                  });
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'image is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              height: 45.0,
                              width: double.infinity,
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0),
                                  side: BorderSide(color: Colors.green[400]),
                                ),
                                color: Colors.green[400],
                                textColor: Colors.white,
                                splashColor: Colors.green[200],
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    this.motherMonth.imageURL = "image Url need to be created";
                                    _databaseService.insertMotherMonth(motherMonth);
                                    Navigator.pop(context);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
