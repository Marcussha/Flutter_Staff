import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {

  Future addStaff (Map<String, dynamic> staffInfoMap, String id)async{
    return await FirebaseFirestore.instance.collection("Staff").doc(id)
        .set(staffInfoMap);

  }
}