import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share/screens/chat_screen.dart';
import 'package:uuid/uuid.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _collection = FirebaseFirestore.instance.collection('user');

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();

    super.dispose();
  }

  getData() async {
    await _collection.doc().set({'name': 'Mahi', 'age': '20'});
    final result = await _collection.get();

    result.docs.forEach((element) {
      print('name : ${element.get('name')}');
      print('age : ${element.get('age')}');
    });
  }

  @override
  void initState() {
    print('initState called');
    getData();
    super.initState();
  }

  validate() {
    return _formKey.currentState.validate();
  }

  // Generate a v1 (time-based) id

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(66, 39, 90, 1),
              Color.fromRGBO(115, 75, 109, 1),
            ],
          ),
          // color: Colors.red,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                'Share',
                style: TextStyle(
                  fontSize: 70.0,
                  fontFamily: "DancingScript",
                  fontWeight: FontWeight.bold,
                  // color: Colors.white,
                  letterSpacing: 10,
                ),
              ),
              Container(
                height: 100,
                child: RotateAnimatedTextKit(
                    onTap: () {
                      print("Tap Event");
                    },
                    repeatForever: true,
                    text: ["TALK", "GOSSIP", "CHATTER"],
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontFamily: "Pacifico",
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 10,
                    ),
                    textAlign: TextAlign.start),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (val) {
                          if (val.trim().length == 0) {
                            return 'Nickname bolona 😏?';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          // suffixIcon: IconButton(
                          //     icon: Icon(
                          //       Icons.arrow_forward_ios_rounded,
                          //       color: Colors.white,
                          //     ),
                          //     onPressed: () {
                          // if (validate()) {
                          //   Navigator.of(context).push(MaterialPageRoute(
                          //       builder: (_) => ChatScreen(
                          //           _nameController.text.trim(), '1223')));
                          // }
                          //     }),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: 'Nickname 😉?',
                        ),
                      ),
                      SizedBox(height: 5),
                      TextFormField(
                        controller: _idController,
                        validator: (val) {
                          if (val.trim().length < 5) {
                            return 'ID must be 5 characters.';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black54,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          hintText: 'Enter your unique ID!',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  if (validate()) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ChatScreen(
                              _nameController.text
                                      .trim()
                                      .substring(0, 1)
                                      .toUpperCase() +
                                  _nameController.text.trim().substring(1),
                              _idController.text.trim(),
                            )));
                  }
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.grey[300],
                  ),
                ),
              ),
              Text('Remember your ID to chat again.',
                  style: TextStyle(
                    fontFamily: 'Pacifico',
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
