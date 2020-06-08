import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';
import 'package:mama_k_app_admin/models/mainTopic.dart';
import 'package:mama_k_app_admin/models/motherMonthModel.dart';
import 'package:mama_k_app_admin/models/motherWeekModel.dart';
import 'package:mama_k_app_admin/models/subTopicModel.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  final firestoreInstance = FirebaseFirestore.instance;
  final storageInstance = FirebaseStorage.instance;

//Baby's Development
  insertBabyWeek(Baby baby) async {
    await firestoreInstance.collection('babyWeek').doc("week" + baby.week.toString()).set(
      {
        'week': baby.week,
        'size': baby.size,
        'weight': baby.weight,
        'imageURL': baby.imageURL,
        'tipDescription': baby.tipDescription,
      },
    );
  }

  Stream<dynamic> getBabyWeekForAdmin(int week) {
    return firestoreInstance.collection("babyWeek").doc("week" + week.toString()).snapshots();
  }

  deleteBabyWeek(int week) {
    return firestoreInstance.collection("babyWeek").doc("week" + week.toString()).delete();
  }

// Mother's development

  insertMotherWeek(MotherInWeek week) async {
    await firestoreInstance.collection('momsInWeek').doc("week" + week.week.toString()).set(
      {
        'month': week.month,
        'week': week.week,
        'tipDescription': week.tipDescription,
      },
    );
  }

  insertMotherMonth(MotherInMonth month) async {
    await firestoreInstance.collection('momsInMonth').doc("month" + month.month.toString()).set(
      {
        'month': month.month,
        'imageURL': month.imageURL,
      },
    );
  }

  Stream<dynamic> getMomWeekForAdmin(int week) {
    return firestoreInstance.collection('momsInWeek').doc("week" + week.toString()).snapshots();
  }

  Stream<dynamic> getMomMOnthForAdmin(int month) {
    return firestoreInstance.collection('momsInMonth').doc("month" + month.toString()).snapshots();
  }

  deleteMomWeek(int week) {
    return firestoreInstance.collection("momsInWeek").doc("week" + week.toString()).delete();
  }

  deleteMomMonth(int month) {
    return firestoreInstance.collection("momsInMonth").doc("month" + month.toString()).delete();
  }

// Initial document setup
  initialStart1() async {
    for (int i = 1; i <= 40; i++) {
      await firestoreInstance.collection('babyWeek').doc("week" + i.toString()).set(
        {
          'week': i,
          'size': 0.0,
          'weight': 0.0,
          'imageURL': '',
          'tipDescription': '',
        },
      );
      print("done");
    }
  }

  initialStart2() async {
    for (int i = 1; i <= 40; i++) {
      await firestoreInstance.collection('momsInWeek').doc("week" + i.toString()).set(
        {
          'week': i,
          'month': 0.0,
          'tipDescription': '',
        },
      );
    }

    for (int i = 1; i <= 10; i++) {
      await firestoreInstance.collection('momsInMonth').doc("month" + i.toString()).set(
        {
          'month': i,
          'imageURL': 'need to be adds',
        },
      );
    }

    print('done');
  }

// TIPS

  insertMainTopic(MainTopic mainTopic) async {
    await firestoreInstance.collection('tips').doc(mainTopic.id).set(
      {
        'id': mainTopic.id,
        'title': mainTopic.title,
        'description': mainTopic.description,
        'imageURL': "need to be update",
      },
    );
  }

  insertSubTopic(String mainTopicId, SubTopicModel subTopic) async {
    await firestoreInstance
        .collection('tips')
        .doc(mainTopicId)
        .collection("subTopics")
        .doc(subTopic.id)
        .set(
      {
        'id': subTopic.id,
        'title': subTopic.title,
        'description': subTopic.description,
      },
    );
  }

  Stream<dynamic> getTipCollection() {
    return firestoreInstance.collection("tips").snapshots();
  }

  Stream<dynamic> getSubTopicCollection(String docId) {
    return firestoreInstance.collection("tips").doc(docId).collection("subTopics").snapshots();
  }

  deleteMainTopic(String id) {
    return firestoreInstance.collection("tips").doc(id).delete();
  }

  deleteSubTopic(String mainTopic, String subTopic) {
    return firestoreInstance
        .collection("tips")
        .doc(mainTopic)
        .collection("subTopics")
        .doc(subTopic)
        .delete();
  }

  String randomIdForMain() {
    var _randomId = firestoreInstance.collection("tips").doc().id;
    return _randomId;
  }

  String randomIdForSub(String mainTopicId) {
    var _randomId =
        firestoreInstance.collection("tips").doc(mainTopicId).collection("subTopics").doc().id;
    print(_randomId);
    return _randomId;
  }


  Future uploadImage(String filePath, File file,Baby baby) async {
    // need to be delete prev: image
    StorageReference storageReference = storageInstance.ref();
    StorageUploadTask uploadTask = storageReference.child(filePath).putFile(file);

    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((downloadURL) {
      baby.imageURL = downloadURL;
      insertBabyWeek(baby);
    });
  }
}
