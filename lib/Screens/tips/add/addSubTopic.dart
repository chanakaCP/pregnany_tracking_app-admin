import 'package:flutter/material.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/models/subTopicModel.dart';
import 'package:mama_k_app_admin/services/databaseService.dart';

class AddSubTopic extends StatefulWidget {
  MainTopic mainTopic = MainTopic() ;
  SubTopicModel subTopic = SubTopicModel();
  AddSubTopic(this.mainTopic,this.subTopic);
  @override
  _AddSubTopicState createState() => _AddSubTopicState();
}

class _AddSubTopicState extends State<AddSubTopic> {
  final _formKey = GlobalKey<FormState>();
  DatabaseService _databaseService = DatabaseService();
  SubTopicModel newTopic = SubTopicModel();
  String id;
  String title;
  String description;
  @override
  Widget build(BuildContext context) {
    this.newTopic.id = this.widget.subTopic.id;
    this.newTopic.title = this.widget.subTopic.title;
    this.newTopic.description = this.widget.subTopic.description;

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
                      width:200.0,
                      child: Text(
                         (this.widget.subTopic.title != '') ? "Update Topic" : "Add New Topic",
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18.0,
                          color: Colors.black54,
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
                            maxLines: null,
                            initialValue: this.widget.subTopic.title,
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
                            initialValue: this.widget.subTopic.description,
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
                                this.newTopic.id = this.widget.subTopic.id;
                                if (this.title != null) this.newTopic.title = this.title;
                                if (this.description != null)
                                  this.newTopic.description = this.description;
                                _databaseService.insertSubTopic(this.widget.mainTopic.id, this.newTopic);
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
  }
}
