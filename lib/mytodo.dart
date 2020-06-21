import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class build extends StatefulWidget {
  @override
  _buildState createState() => _buildState();
}

class _buildState extends State<build> {
  final db = Firestore.instance;
  String id;
  void readData() async {
    DocumentSnapshot snapshot = await db.collection('CRUD').document(id).get();
    print(snapshot.data['name']);
  }
    Card buildItem(DocumentSnapshot doc) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'name: ${doc.data['name']}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'todo: ${doc.data['todo']}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    onPressed: () => null,
                    child: Text('Update todo', style: TextStyle(color: Colors.white)),
                    color: Colors.green,
                  ),
                  SizedBox(width: 8),
                  FlatButton(
                    onPressed: () => null,
                    child: Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore CRUD'),
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: db.collection('CRUD').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          )
        ],
      ),
    );
  }

}

