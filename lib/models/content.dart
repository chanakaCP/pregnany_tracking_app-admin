import 'package:mama_k_app_admin/models/subContent.dart';

class Content {
  String contentId;
  int priority;
  String title;
  String description;
  String imageURL;
  List<SubContent> subTopics = new List();
}
