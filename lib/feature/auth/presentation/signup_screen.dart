import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testflutter/feature/auth/controller/login_controller.dart';
import 'package:testflutter/feature/auth/presentation/login_screen.dart';
import 'package:testflutter/helper/input_text_field_widget.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthController c = Get.put(AuthController());
    return Scaffold(
      body: Form(
        key: c.formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Column(
                      children: [
                        const SizedBox(height: 50.0),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 40.0),
                        ),
                        const SizedBox(height: 10.0),
                        Image.network(
                          "https://img.freepik.com/free-vector/access-control-system-abstract-concept_335657-3180.jpg?w=1060&t=st=1676445986~exp=1676446586~hmac=3804247f31eefca9909e1c247a852b206871f2ffb6871b68097e8af66d2e5224",
                          height: 150.0,
                          width: 150.0,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                  InputTextField(
                      controller: c.userIdCtrl,
                      icon: Icons.person,
                      hintName: 'User Id'),
                  const SizedBox(height: 10.0),
                  InputTextField(
                      controller: c.usernameCtrl,
                      icon: Icons.email,
                      hintName: 'Username'),
                  const SizedBox(height: 10.0),
                  InputTextField(
                      controller: c.emailCtrl,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  const SizedBox(height: 10.0),
                  InputTextField(
                    controller: c.passwordCtrl,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  const SizedBox(height: 10.0),
                  InputTextField(
                    controller: c.cPasswordCtrl,
                    icon: Icons.lock,
                    hintName: 'Confirm Password',
                    isObscureText: true,
                  ),
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    width: double.infinity,
                    height: 40,
                    // decoration: BoxDecoration(
                    //   color: Colors.blue,
                    //   borderRadius: BorderRadius.circular(30.0),
                    // ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F35A5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onPressed: c.signUp,
                      child: const Text(
                        'Signup',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Does you have account? '),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6F35A5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          // textColor: Colors.blue,
                          child: const Text('Login'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                (Route<dynamic> route) => false);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
