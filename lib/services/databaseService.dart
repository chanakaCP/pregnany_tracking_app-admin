import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mama_k_app_admin/models/babyModel.dart';

class DatabaseService {
  final firestoreInstance = FirebaseFirestore.instance;

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
}
