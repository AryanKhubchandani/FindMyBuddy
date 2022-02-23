import 'package:find_my_buddy/services/sharedprefs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future updateUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .update(userInfoMap);
  }

  Future<QuerySnapshot> getUserInfo(String phoneNumber) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get();
  }

  Future<Stream<QuerySnapshot>> getUsers() async {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }
}
