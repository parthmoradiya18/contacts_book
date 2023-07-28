import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:github_app/main.dart';

import 'package:http/http.dart' as http;

import 'mymodel.dart';

class view extends StatefulWidget {
  const view({Key? key}) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
  getdata() async {
    var url =
        Uri.parse('https://parthmoradiya.000webhostapp.com/view_contact.php');
    var response = await http.get(url);
    List l = jsonDecode(response.body);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view contact"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            List list = snapshot.data as List;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                model m = model.fromJson(list[index]);
                print(m);
                return Card(
                  margin: EdgeInsets.all(5),
                  color: Colors.grey,
                  child: ListTile(
                  //  trailing: Image.network("${m.image}"),
                    // trailing:
                    //     CircleAvatar(backgroundImage: NetworkImage("https://parthmoradiya.000webhostapp.com/myimg1/${m.image}"),),

                    title: Text("${m.name}"),
                    subtitle: Text("${m.contact}"),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
