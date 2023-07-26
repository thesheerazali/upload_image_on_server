import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_apis_work/models/users.dart';
import 'package:http/http.dart' as http;

class ExampleOneUsingModelClass extends StatelessWidget {
  ExampleOneUsingModelClass({super.key});

  final List<UsersModel> usersList = [];

  Future<List<UsersModel>> getDatafromApi() async {
    final responce =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> i in data) {
        usersList.add(UsersModel.fromJson(i));
      }

      return usersList;
    } else {
      return usersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example One Using Model Class"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDatafromApi(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Details(
                              title: "Name", value: snapshot.data![index].name),
                          Details(
                              title: "Email",
                              value: snapshot.data![index].email),
                          Details(
                              title: "Adress",
                              value: snapshot.data![index].address.city),
                          Details(
                              title: "Phone",
                              value: snapshot.data![index].phone),
                        ]),
                      ),
                    );
                  },
                );
              }
            },
          )),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  const Details({super.key, required this.title, this.value});

  final String title;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
