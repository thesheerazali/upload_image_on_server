import 'package:flutter/material.dart';
import 'package:flutter_apis_work/postexamples/login_example.dart';
import 'package:flutter_apis_work/postexamples/signup_example.dart';
import 'package:flutter_apis_work/postexamples/upload_image_on_server.dart';

import 'getexamples/complex_api_data.dart';

//import 'getexamples/complex_api_data.dart';
//import 'getexamples/example_one_without_model_class.dart';

void main() {
  runApp(const ApiWork());
}

class ApiWork extends StatelessWidget {
  const ApiWork({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageUploadOnServer(),
    );
  }
}
