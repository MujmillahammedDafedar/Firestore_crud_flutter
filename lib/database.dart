import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
class Backend{
  final db = Firestore.instance;
String title, descr;
  void createData(String name, String desc) async {
    //DocumentReference ref = await db.collection('todo').add({'title': '$name', 'desc': '$desc'});
    print('$name and $desc');

  }

}