import 'package:flutter/material.dart';
import 'package:http/http.dart' ;

class LoginExample extends StatefulWidget {
  LoginExample({super.key});

  @override
  State<LoginExample> createState() => _LoginExampleState();
}

class _LoginExampleState extends State<LoginExample> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  var isLogin = "";
  var changeButton = false;

  void login(String email, password) async {
    try {
      Response responce =
          await post(Uri.parse("https://reqres.in/api/login"), body: {
        'email': email,
        'password': password,
      });

      if (responce.statusCode == 200) {
        setState(() {
          changeButton = true;
          isLogin = "LogIn Succesfull";
        });

        print("Login Succesfully");
      } else {
        setState(() {
          changeButton = false;
        });

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
          title: Text("Login"),
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
                onTapOutside: (event) =>
                    FocusManager.instance.primaryFocus?.unfocus(),
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
                  width: changeButton ? 50 : double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepPurple,
                  ),
                  child: changeButton
                      ? const Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              isLogin == ""
                  ? SizedBox()
                  : Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.deepPurple,
                      ),
                      child: Center(
                        child: Text(
                          isLogin,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
