import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';
import 'package:mama_k_app_admin/models/motherMonthModel.dart';
import 'package:mama_k_app_admin/models/motherWeekModel.dart';

class DatabaseService {
  final firestoreInstance = FirebaseFirestore.instance;

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

  deleteMomWeek(int week) {
    return firestoreInstance.collection("momsInWeek").doc("week" + week.toString()).delete();
  }

  deleteMomMonth(int month) {
    return firestoreInstance.collection("momsInMonth").doc("month" + month.toString()).delete();
  }
}
