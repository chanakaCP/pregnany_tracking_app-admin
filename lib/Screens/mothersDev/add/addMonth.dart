import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/models/motherMonthModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

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
  String imageURL;
  File _imageFile;

  Future getImage() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      setState(() {
        _imageFile = image;
        imageURL = image.path;
      });
    });
  }

  clearImage() {
    setState(() {
      _imageFile = null;
      imageURL = null;
    });
  }

  @override
  void initState() {
    _imageFile = null;
    userStream = _databaseService.getMomMOnthForAdmin(this.widget.month);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    motherMonth.month = this.widget.month;
    return StreamBuilder(
      stream: userStream,
      builder: (context, currentStream) {
        if (currentStream.hasData) {
          motherMonth.imageURL = currentStream.data["imageURL"];
          imageURL = currentStream.data['imageURL'];
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
                      SizedBox(height: 75.0),
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Pick a Image",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 17.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 50.0),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.2),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: InkWell(
                                      child: Icon(
                                        Icons.add_a_photo,
                                        size: 20.0,
                                        color: Colors.green[800],
                                      ),
                                      onTap: () {
                                        getImage();
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20.0),
                                  (imageURL != null)
                                      ? Container(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withOpacity(0.2),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          child: InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              size: 20.0,
                                              color: Colors.green[800],
                                            ),
                                            onTap: () {
                                              clearImage();
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                height: 150.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 3,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  image: DecorationImage(
                                    image: loadImage(),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                              SizedBox(height: 40.0),
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
                                      if (_imageFile != null) {
                                        String imagePath = "MotherInMonth/month" +
                                            this.widget.month.toString() +
                                            "-" +
                                            Path.basename(_imageFile.path).toString();
                                        _databaseService.uploadImage(
                                            imagePath, _imageFile, this.motherMonth, context);
                                      } else {
                                        print("image can't be null");
                                      }
                                    } else {
                                      print("form validate fail");
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
        } else {
          return SafeArea(
            child: Scaffold(
              body: Container(
                child: Text("Loading"),
              ),
            ),
          );
        }
      },
    );
  }

  loadImage() {
    if (imageURL == "" && _imageFile == null) {
      print("1");
      return AssetImage("images/imageSelect.png"); // load defaluld icon
    } else if (_imageFile != null) {
      print("2");
      return AssetImage(_imageFile.path); // load selected image
    } else {
      print("3");
      return NetworkImage(this.motherMonth.imageURL); // load from database
    }
  }
}
