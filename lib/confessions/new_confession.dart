import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/confessions.dart';
import '../services/firestore_services.dart';

class NewConfessionScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  final uuid = Uuid();
  Color currentColor = Colors.limeAccent;

  void changeColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: (Color color) {
                currentColor = color;
              },
              // ignore: deprecated_member_use
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Confession',
          style: TextStyle(fontFamily: "Product Sans Bold"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                maxLines: null,
                decoration: InputDecoration(
                    fillColor: Colors.deepPurple,
                    labelText: 'Enter your confession',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontFamily: "Product Sans Regular",
                      fontSize: 13,
                    ),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your confession';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => changeColor(context),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Choose Card Color',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final confession = Confession(
                        id: uuid.v4(),
                        content: _controller.text,
                        username:
                            'King', // assign "King" to the creator of the post
                        upvotes: 2,
                        downvotes: 0,
                        timestamp: DateTime.now(),
                        isAnonymous: false,
                        color: currentColor,
                      );
                      final firestore = ref.read(firestoreProvider);
                      await firestore.postConfession(confession);

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
