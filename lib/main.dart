import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Share knowledge through written';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade700,
          title: Text(appTitle),
        ),
        body: SafeArea(
          child: MyCustomForm(),
        ),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>
  // .
  String id;
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();
  String title, descr,end;

  void createData() async {
    _formKey.currentState.save();
    DocumentReference ref = await db
        .collection('asdasd')
        .add({'title': '$title', 'desc': '$descr','end': '$end'}).whenComplete(
      () => Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Successfuly created data'))),
    );
    setState(() => id = ref.documentID);
    print(ref.documentID);
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "To do title",
                    fillColor: Colors.teal,
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.teal.shade400)),
                  ),
                  style: TextStyle(
                      fontFamily: 'Sriracha',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'To do titles is empty';
                    }
                    return null;
                  },
                  onSaved: (value) => title = value,
                ),

                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "What is your to do",
                    fillColor: Colors.teal,
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.teal.shade400)),
                  ),
                  style: TextStyle(
                      fontFamily: 'Sriracha',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'To do list is empty';
                    }
                    return null;
                  },
                  onSaved: (value) => descr = value,
                ),

                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "When you going to end",
                    fillColor: Colors.teal,
                    border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.teal.shade400)),
                  ),
                  style: TextStyle(
                      fontFamily: 'Sriracha',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'When you going to end is empty';
                    }
                    return null;
                  },
                  onSaved: (value) => end = value,
                ),

                SizedBox(
                  height: 10.0,
                ),
                ButtonTheme(
                  minWidth: 200.0,
                  height: 40.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      color: Colors.teal.shade100,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.teal)
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            // If the form is valid, display a Snackbar.
                            createData();
                          }
                        });
                        // Validate returns true if the form is valid, or false
                        // otherwise.
                      },

                      child: Text(
                        'Create todo',
                        style: TextStyle(
                            fontFamily: 'Sriracha',
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54),

                      ),
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
