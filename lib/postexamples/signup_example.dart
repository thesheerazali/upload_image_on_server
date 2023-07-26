import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpExamp extends StatelessWidget {
  SignUpExamp({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response responce =
          await post(Uri.parse("https://reqres.in/api/register"), body: {
        'email': email,
        'password': password,
      });

      if (responce.statusCode == 200) {
        print("account Created Succesfully");
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
               onTapOutside: (event) =>  FocusManager.instance.primaryFocus?.unfocus() ,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
               
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple,
                  ),
                  child: const Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
