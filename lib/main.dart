import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_app/view.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  String? id;
  String? name;
  String? contact;

  Home([this.id, this.name, this.contact]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  ImagePicker picker = ImagePicker();
  PickedFile? photo;
  bool is_upload = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      t1.text = widget.name!;
      t2.text = widget.contact!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add contact"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(margin: EdgeInsets.all(5),
              color: Colors.grey,
              child: TextField(
                controller: t1,
                decoration: InputDecoration(
                    hintText: "Enter name", labelText: "Enter name"),
              ),
            ),
            Card(color: Colors.grey,
              margin: EdgeInsets.all(5),
              child: TextField(
                controller: t2,
                decoration: InputDecoration(
                    hintText: "Enter contact", labelText: "Enter contact"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  photo = await picker.getImage(source: ImageSource.camera);
                  is_upload = true;
                  setState(() {});
                },
                child: Text("upload image")),
            Container(
              height: 100,
              width: 100,
              child: (is_upload)
                  ? Image.file(File(photo!.path))
                  : Icon(Icons.account_circle_rounded),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black)),
            ),
            ElevatedButton(
                onPressed: () async {
                  String name, contact;
                  name = t1.text;
                  contact = t2.text;
                  String img_path = base64Encode(await photo!.readAsBytes());
                  var url = Uri.parse(
                      'https://parthmoradiya.000webhostapp.com/Add_contact.php');
                  var response = await http.post(url, body: {
                    'name': '$name',
                    'contact': '$contact',
                    'image': '$img_path'
                  });
                  print('Response status: ${response.statusCode}');
                  print('Response body: ${response.body}');

                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return view();
                  }));
                },
                child: Text("Add contact")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return view();
                  }));
                },
                child: Text("view contact")),
          ],
        ),
      ),
    );
  }
}
