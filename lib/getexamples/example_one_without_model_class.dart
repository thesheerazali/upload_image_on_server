import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleOneWithoutModelClass extends StatelessWidget {
  ExampleOneWithoutModelClass({super.key});

  var data;
  Future<void> getDatafromApi() async {
    final responce =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Example One With Out Using Model Class"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDatafromApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(children: [
                          Details(
                              title: "Name", value: data[0]['name'].toString()),
                          Details(
                              title: "Email",
                              value: data[0]['email'].toString()),
                          Details(
                              title: "Adress",
                              value: data[0]['address']['city'].toString()),
                          Details(
                              title: "Phone",
                              value: data[0]['phone'].toString()),
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
