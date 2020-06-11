import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/Screens/tips/subTopic/subTopic.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';

class AddMainTopic extends StatefulWidget {
  MainTopic mainTopic = MainTopic();
  AddMainTopic(this.mainTopic);
  @override
  _AddMainTopicState createState() => _AddMainTopicState();
}

class _AddMainTopicState extends State<AddMainTopic> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService _databaseService = DatabaseService();
  MainTopic newTopic = MainTopic();
  String id,title,description,imageURL;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.newTopic.id = this.widget.mainTopic.id;
    this.newTopic.title = this.widget.mainTopic.title;
    this.newTopic.description = this.widget.mainTopic.description;
    this.newTopic.imageURL = this.widget.mainTopic.imageURL;
    this.imageURL = this.widget.mainTopic.imageURL;
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
                      width: (this.widget.mainTopic.title != "") ? 100.0 : 150.0,
                      child: Text(
                        (this.widget.mainTopic.title != "") ? "Update Topic" : " Add new Topic",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18.0,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    (this.newTopic.title != "") ?
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
                          "Sub Topics",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18.0,
                            color: Colors.green[900],
                          ),
                        ),
                      ),
                      onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubTopic(this.widget.mainTopic),
                          ),
                        );
                      },
                    ) :
                    Container(),
                  ],
                ),
                SizedBox(height: 50.0),
                Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: TextFormField(
                            maxLines: null,
                            initialValue: this.widget.mainTopic.title,
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
                              hintText: "Title ",
                              filled: true,
                              fillColor: Colors.green[50],
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.title = value;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Title is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Container(
                          child: TextFormField(
                            maxLines: null,
                            initialValue: this.widget.mainTopic.description,
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
                              hintText: "Description ",
                              filled: true,
                              fillColor: Colors.green[50],
                              border: InputBorder.none,
                            ),
                            onChanged: (value) {
                              setState(() {
                                this.description = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
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
                                this.newTopic.id = this.widget.mainTopic.id;
                                if (this.title != null) this.newTopic.title = this.title;
                                if (this.description != null)
                                  this.newTopic.description = this.description;
                                if (_imageFile != null) {
                                  String imagePath = "MainTopic/Topic" +
                                      this.title.toString() +
                                      "-" +
                                      Path.basename(_imageFile.path).toString();
                                  _databaseService.uploadImage(
                                      imagePath, _imageFile, this.newTopic, context);
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
      return NetworkImage(this.newTopic.imageURL); // load from database
    }
  }
}
