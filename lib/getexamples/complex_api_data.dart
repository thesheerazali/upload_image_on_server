import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/products_model.dart';

class ComplexApiData extends StatefulWidget {
  const ComplexApiData({Key? key}) : super(key: key);

  @override
  _ComplexApiDataState createState() => _ComplexApiDataState();
}

class _ComplexApiDataState extends State<ComplexApiData> {
  Future<ProductModel> getProductsApi() async {
    //create your own api
    final response = await http.get(
        Uri.parse('https://mocki.io/v1/7055baba-4065-4449-b998-59c5c7cce951'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductModel.fromJson(data);
    } else {
      return ProductModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Get Data From Api '),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductModel>(
                future: getProductsApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                        child: const CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.data.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data[index].shop.name
                                    .toString()),
                                subtitle: Text(snapshot
                                    .data!.data[index].shop.shopemail
                                    .toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data!.data[index].shop.image
                                      .toString()),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data[index].images.length,
                                    itemBuilder: (context, position) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .data[index]
                                                      .images[position]
                                                      .url
                                                      .toString()))),
                                        ),
                                      );
                                    }),
                              ),
                              Icon(
                                  snapshot.data!.data[index].inWishlist == false
                                      ? Icons.favorite
                                      : Icons.favorite_outline)
                            ],
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
