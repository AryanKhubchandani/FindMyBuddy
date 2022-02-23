import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_my_buddy/services/sharedprefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _formKey = GlobalKey<FormState>();

  String myNumber = '';
  getInfo() async {
    myNumber = (await SharedPrefs().getPhoneNumber())!;
  }

  String petName = '';
  String breed = '';
  String age = '';
  String gender = '';
  String imagePath = '';

  String url = '';

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> _upload() async {
    final picker = ImagePicker();

    PickedFile? pickedImage;
    try {
      pickedImage = await picker.getImage(
        source: ImageSource.gallery,
      );

      final String fileName = path.basename(pickedImage!.path);
      File imageFile = File(pickedImage.path);

      try {
        Reference ref = storage.ref().child(myNumber);

        UploadTask uploadTask = ref.putFile(imageFile);
        uploadTask.whenComplete(() async {
          // url = await ref.getDownloadURL();
          // updateImg();
          setState(() {});
        }).catchError((onError) {
          print(onError);
        });
        setState(() {});
      } on FirebaseException catch (error) {
        print(error);
      }
    } catch (err) {
      print(err);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    'Add a Buddy',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pet's Name",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? "Enter a name" : null,
                  onChanged: (val) {
                    setState(() => petName = val);
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pet's Breed",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? "Enter a name" : null,
                  onChanged: (val) {
                    setState(() => breed = val);
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pet's Age",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? "Enter a name" : null,
                  onChanged: (val) {
                    setState(() => age = val);
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Pet's Gender",
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.indigo, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.blue, width: 2),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? "Enter a name" : null,
                  onChanged: (val) {
                    setState(() => gender = val);
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                width: 160,
                height: 170,
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        _upload();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 30,
                              offset: Offset(0, 10),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(22),
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.fill,
                          ),
                        ),
                        margin: EdgeInsets.only(top: 10),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 200, height: 50),
                  child: ElevatedButton(
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      // if (_formKey.currentState!.validate()) {
                      //   dynamic result = await _auth.registerEnP(email, password);
                      //   if (result == null) {
                      //     setState(() => error = "Enter a valid Email");
                      //   }
                      // }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                      side: BorderSide(color: Colors.blue, width: 2),
                    ),
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
