import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dynamic Form'),
        ),
        body: DynamicForm(),
      ),
    );
  }
}

class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  // List of controllers for each field
  List<TextEditingController> _controllers = [TextEditingController()];

  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Generate a TextFormField for each controller
            ..._controllers.map((controller) {
              int index = _controllers.indexOf(controller);
              return TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'Field ${index + 1}',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              );
            }).toList(),
            ElevatedButton(
              child: Text('Add Field'),
              onPressed: () {
                setState(() {
                  _controllers.add(TextEditingController());
                });
              },
            ),
            ElevatedButton(
              child: Text('Remove Last Field'),
              onPressed: () {
                if (_controllers.length > 1) {
                  setState(() {
                    _controllers.removeLast();
                  });
                }
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _controllers.forEach((controller) {
                    print(controller.text);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}