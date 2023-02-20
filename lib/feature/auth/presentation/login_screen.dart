import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/feature/auth/controller/login_controller.dart';
import 'package:testflutter/feature/home/home_screen.dart';
import 'package:testflutter/feature/auth/presentation/signup_screen.dart';
import 'package:testflutter/feature/qr/qr_screen.dart';
import 'package:testflutter/helper/database_helper.dart';
import 'package:testflutter/helper/input_text_field_widget.dart';
import 'package:testflutter/helper/preference_helper.dart';
import 'package:testflutter/widgets/global_widget.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  final _usernameCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  var dbHelper;
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  PreferencesHelper preferencesHelper =
      PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
  List<BiometricType> _availableBiometricType = [];
  String _authorizedOrNot = "Not Authorized";
  bool _hasFingerPrintSupport = false;
  final bool _isSharedPrefNull = true;

  @override
  void initState() {
    super.initState();
    _getAvailableSupport();
    _getBiometricSupport();
    dbHelper = DbHelper();
  }

  Future<void> _getBiometricSupport() async {
    bool hasFingerPrintSupport = false;
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
    } catch (e) {
      log(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _hasFingerPrintSupport = hasFingerPrintSupport;
    });
  }

  Future<void> _getAvailableSupport() async {
    List<BiometricType> availableBiometricType = [];
    try {
      availableBiometricType =
          await _localAuthentication.getAvailableBiometrics();
    } catch (e) {
      log(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _availableBiometricType = availableBiometricType;
    });
  }

  Future<void> _authenticateMe(
      AuthController c, String username, String password) async {
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticate(
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
          localizedReason: "Gunakan sidik jari untuk login");
    } catch (e) {
      log(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    });
    //NOTE: if authenticated get SharedPref & doLogin
    if (authenticated) {
      await dbHelper.getLoginUser(username, password).then((userData) {
        if (userData != null) {
          c.setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (Route<dynamic> route) => false);
          });
        } else {
          GlobalWidget.showAlertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        GlobalWidget.showAlertDialog(context, "Error: Login Fail");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthController c = Get.put(AuthController());
    return Scaffold(
      body: SingleChildScrollView(
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
                        'Login',
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
                // genLoginSignupHeader('Login'),
                InputTextField(
                    controller: _usernameCtrl,
                    icon: Icons.person,
                    hintName: 'Email'),
                const SizedBox(height: 10.0),
                InputTextField(
                  controller: _passwordCtrl,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      width: 160,
                      // decoration: BoxDecoration(
                      //   color: Colors.blue,
                      //   borderRadius: BorderRadius.circular(30.0),
                      // ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6F35A5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        onPressed: () {
                          c.login(_usernameCtrl.text, _passwordCtrl.text);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6F35A5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          onPressed: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const QRViewScreen(),
                            ));
                          },
                          child:
                              const Icon(Icons.qr_code, color: Colors.white)),
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    SizedBox(
                      width: 80,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6F35A5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          onPressed: () {
                            preferencesHelper.getLoginAuth.then((value) {
                              log(value);
                              if (value.contains(';')) {
                                String data1 =
                                    value.substring(0, value.indexOf(';'));
                                String data2 =
                                    value.substring(value.indexOf(';') + 1);
                                _authenticateMe(c, data1, data2);
                              } else {
                                FocusScope.of(context).unfocus();
                                GlobalWidget.showAlertDialog(context,
                                    'untuk mengaktifkan fitur fingerprint, login terlebih dahulu menggunakan username dan password');
                                log('Shared Pref kosong');
                              }
                            });
                          },
                          child: const Icon(Icons.fingerprint,
                              color: Colors.white)),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Does not have account? '),
                      TextButton(
                        // textColor: Colors.blue,
                        child: const Text(
                          'Signup',
                          style: TextStyle(color: Color(0xFF6F35A5)),
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => SignupForm()));
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
    );
  }
}
