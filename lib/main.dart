import 'package:flutter/material.dart';
import 'database.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
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
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final Backend back = new Backend();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter title'
            ),

            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            onSaved: (value) => back.title = value,

          ),
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter title',
               filled: true,

            ),

            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some desc';
              }
              return null;
            },
            onSaved: (value) => back.descr = value,

          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  if (_formKey.currentState.validate()) {
                    // If the form is valid, display a Snackbar.
                    back.createData(back.title, back.descr);
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Wait man data will inserting to firebase')));
                  }
                });
                // Validate returns true if the form is valid, or false
                // otherwise.

              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}


