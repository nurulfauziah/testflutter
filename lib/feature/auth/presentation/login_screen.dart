// // // ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

// // import 'dart:developer';

// // import 'package:flutter/material.dart';
// // import 'package:local_auth/local_auth.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:testflutter/feature/login/model/user_model.dart';
// // import 'package:testflutter/feature/login/response/login_response.dart';
// // import 'package:testflutter/helper/preference_helper.dart';
// // import 'package:testflutter/widgets/global_widget.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({Key? key}) : super(key: key);

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen> implements LoginCallBack {
// //   // BuildContext _ctx;
// //   bool _isLoading = false;
// //   final formKey = GlobalKey<FormState>();
// //   final scaffoldKey = GlobalKey<ScaffoldState>();
// //   String? _username, _password;
// //   LoginResponse? _response;
// //   _LoginPageState() {
// //     _response = LoginResponse(this);
// //   }

// //   void _submit() {
// //     final form = formKey.currentState;
// //     if (form!.validate()) {
// //       setState(() {
// //         _isLoading = true;
// //         form.save();
// //         _response?.doLogin(_username ?? '', _password ?? '');
// //       });
// //     }
// //   }

// //   void _showSnackBar(String text) {
// //     GlobalWidget.showAlertDialog(context, text);
// //     // scaffoldKey.currentState.showSnackBar(SnackBar(
// //     //   content: Text(text),
// //     // ));
// //   }

// //   final LocalAuthentication _localAuthentication = LocalAuthentication();

// //   PreferencesHelper preferencesHelper =
// //       PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());
// //   List<BiometricType> _availableBiometricType = [];
// //   String _authorizedOrNot = "Not Authorized";
// //   bool _hasFingerPrintSupport = false;
// //   bool _isSharedPrefNull = true;

// //   Future<void> _getBiometricSupport() async {
// //     bool hasFingerPrintSupport = false;
// //     try {
// //       hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //     if (!mounted) return;
// //     setState(() {
// //       _hasFingerPrintSupport = hasFingerPrintSupport;
// //     });
// //   }

// //   Future<void> _getAvailableSupport() async {
// //     List<BiometricType> availableBiometricType = [];
// //     try {
// //       availableBiometricType =
// //           await _localAuthentication.getAvailableBiometrics();
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //     if (!mounted) return;
// //     setState(() {
// //       _availableBiometricType = availableBiometricType;
// //     });
// //   }

// //   Future<void> _authenticateMe(
// //       // LoginProvider loginProvider,
// //       // AccInqAllProvider inqAllAccountProvider,
// //       String username,
// //       String password) async {
// //     bool authenticated = false;
// //     try {
// //       authenticated = await _localAuthentication.authenticate(
// //           options: const AuthenticationOptions(
// //             stickyAuth: true,
// //           ),
// //           localizedReason: "Gunakan sidik jari untuk login");
// //     } catch (e) {
// //       log(e.toString());
// //     }
// //     if (!mounted) return;
// //     setState(() {
// //       _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
// //     });
// //     //NOTE: if authenticated get SharedPref & doLogin
// //     if (authenticated) {
// //       /// to do auth (login)
// //       // loginProvider.submitLogin(
// //       //     username, password, VarSession.fcmToken, inqAllAccountProvider);
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Theme(
// //       data: ThemeData(
// //         primaryColor: const Color(0xFF6F35A5),
// //         scaffoldBackgroundColor: Colors.white,
// //         elevatedButtonTheme: ElevatedButtonThemeData(
// //           style: ElevatedButton.styleFrom(
// //             elevation: 0,
// //             backgroundColor: const Color(0xFF6F35A5),
// //             shape: const StadiumBorder(),
// //             maximumSize: const Size(double.infinity, 56),
// //             minimumSize: const Size(double.infinity, 56),
// //           ),
// //         ),
// //         inputDecorationTheme: const InputDecorationTheme(
// //           filled: true,
// //           fillColor: Color(0xFFF1E6FF),
// //           iconColor: Color(0xFF6F35A5),
// //           prefixIconColor: Color(0xFF6F35A5),
// //           contentPadding:
// //               EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.all(Radius.circular(30)),
// //             borderSide: BorderSide.none,
// //           ),
// //         ),
// //       ),
// //       child: Scaffold(
// //         resizeToAvoidBottomInset: true,
// //         body: SizedBox(
// //           width: double.infinity,
// //           height: MediaQuery.of(context).size.height,
// //           child: Stack(
// //             alignment: Alignment.center,
// //             children: <Widget>[
// //               // Positioned(
// //               //   top: 0,
// //               //   left: 0,
// //               //   child: Image.network(
// //               //     "https://img.freepik.com/free-vector/access-control-system-abstract-concept_335657-3180.jpg?w=1060&t=st=1676445986~exp=1676446586~hmac=3804247f31eefca9909e1c247a852b206871f2ffb6871b68097e8af66d2e5224",
// //               //     width: 120,
// //               //   ),
// //               // ),
// //               SafeArea(
// //                 child: SingleChildScrollView(
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: <Widget>[
// //                       Column(
// //                         children: [
// //                           const Text(
// //                             "LOGIN",
// //                             style: TextStyle(fontWeight: FontWeight.bold),
// //                           ),
// //                           const SizedBox(height: 16.0 * 2),
// //                           Row(
// //                             children: [
// //                               const Spacer(),
// //                               Expanded(
// //                                 flex: 8,
// //                                 child: Image.network(
// //                                   "https://img.freepik.com/free-vector/access-control-system-abstract-concept_335657-3180.jpg?w=1060&t=st=1676445986~exp=1676446586~hmac=3804247f31eefca9909e1c247a852b206871f2ffb6871b68097e8af66d2e5224",
// //                                   width: 120,
// //                                 ),
// //                               ),
// //                               const Spacer(),
// //                             ],
// //                           ),
// //                           const SizedBox(height: 16.0 * 2),
// //                         ],
// //                       ),
// //                       Row(
// //                         children: [
// //                           const Spacer(),
// //                           Expanded(
// //                             flex: 8,
// //                             child: Form(
// //                               key: formKey,
// //                               child: Column(
// //                                 children: [
// //                                   TextFormField(
// //                                     keyboardType: TextInputType.emailAddress,
// //                                     textInputAction: TextInputAction.next,
// //                                     cursorColor: const Color(0xFF6F35A5),
// //                                     onSaved: (email) {
// //                                       _username = email;
// //                                     },
// //                                     decoration: const InputDecoration(
// //                                       hintText: "Your email",
// //                                       prefixIcon: Padding(
// //                                         padding: EdgeInsets.all(16.0),
// //                                         child: Icon(Icons.person),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   Padding(
// //                                     padding: const EdgeInsets.symmetric(
// //                                         vertical: 16.0),
// //                                     child: TextFormField(
// //                                       textInputAction: TextInputAction.done,
// //                                       obscureText: true,
// //                                       cursorColor: const Color(0xFF6F35A5),
// //                                       onSaved: (password) {
// //                                         _password = password;
// //                                       },
// //                                       decoration: const InputDecoration(
// //                                         hintText: "Your password",
// //                                         prefixIcon: Padding(
// //                                           padding: EdgeInsets.all(16.0),
// //                                           child: Icon(Icons.lock),
// //                                         ),
// //                                       ),
// //                                     ),
// //                                   ),
// //                                   const SizedBox(height: 16.0),
// //                                   Row(
// //                                     children: [
// //                                       SizedBox(
// //                                         width: 200,
// //                                         child: ElevatedButton(
// //                                           style: ElevatedButton.styleFrom(
// //                                             backgroundColor:
// //                                                 const Color(0xFF6F35A5),
// //                                             shape: RoundedRectangleBorder(
// //                                                 borderRadius:
// //                                                     BorderRadius.circular(
// //                                                         16.0)),
// //                                           ),
// //                                           onPressed: () {
// //                                             _submit();
// //                                           },
// //                                           child: Text(
// //                                             "Login".toUpperCase(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       const SizedBox(
// //                                         width: 10.0,
// //                                       ),
// //                                       SizedBox(
// //                                         width: 100,
// //                                         child: ElevatedButton(
// //                                             style: ElevatedButton.styleFrom(
// //                                               backgroundColor:
// //                                                   const Color(0xFF6F35A5),
// //                                               shape: RoundedRectangleBorder(
// //                                                   borderRadius:
// //                                                       BorderRadius.circular(
// //                                                           16.0)),
// //                                             ),
// //                                             onPressed: () {
// //                                               preferencesHelper.getLoginAuth
// //                                                   .then((value) {
// //                                                 log(value);
// //                                                 if (value.contains(';')) {
// //                                                   String data1 =
// //                                                       value.substring(0,
// //                                                           value.indexOf(';'));
// //                                                   String data2 =
// //                                                       value.substring(
// //                                                           value.indexOf(';') +
// //                                                               1);
// //                                                   _authenticateMe(data1, data2);
// //                                                 } else {
// //                                                   FocusScope.of(context)
// //                                                       .unfocus();
// //                                                   GlobalWidget.showAlertDialog(
// //                                                       context,
// //                                                       'untuk mengaktifkan fitur fingerprint, login terlebih dahulu menggunakan username dan password');
// //                                                   log('Shared Pref kosong');
// //                                                 }
// //                                               });
// //                                             },
// //                                             child: const Icon(Icons.fingerprint,
// //                                                 color: Colors.white)),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                   const SizedBox(height: 16.0),
// //                                   Row(
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     children: <Widget>[
// //                                       const Text(
// //                                         "Don’t have an Account ? ",
// //                                         style:
// //                                             TextStyle(color: Color(0xFF6F35A5)),
// //                                       ),
// //                                       GestureDetector(
// //                                         onTap: () {
// //                                           Navigator.push(
// //                                             context,
// //                                             MaterialPageRoute(
// //                                               builder: (context) {
// //                                                 return Container();
// //                                               },
// //                                             ),
// //                                           );
// //                                         },
// //                                         child: const Text(
// //                                           "Sign Up",
// //                                           style: TextStyle(
// //                                             color: Color(0xFF6F35A5),
// //                                             fontWeight: FontWeight.bold,
// //                                           ),
// //                                         ),
// //                                       )
// //                                     ],
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                           const Spacer(),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   void initState() {
// //     _getBiometricSupport();
// //     _getAvailableSupport();

// //     preferencesHelper.getLoginAuth.then((value) {
// //       if (!mounted) return;
// //       setState(() {
// //         _isSharedPrefNull = false;
// //       });
// //     });
// //     // TODO: implement initState
// //     super.initState();
// //   }

// //   @override
// //   void onLoginError(String error) {
// //     _showSnackBar(error);
// //     setState(() {
// //       _isLoading = false;
// //     });
// //     // TODO: implement onLoginError
// //   }

// //   @override
// //   void onLoginSuccess(User user) {
// //     if (user != null) {
// //       Navigator.of(context).pushNamed("/home");
// //     } else {
// //       // TODO: implement onLoginSuccess
// //       _showSnackBar("Login Gagal, Silahkan Periksa Login Anda");
// //       setState(() {
// //         _isLoading = false;
// //       });
// //     }
// //     // TODO: implement onLoginSuccess
// //   }
// // }

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/feature/auth/model/user_model.dart';
import 'package:testflutter/feature/home/home_screen.dart';
import 'package:testflutter/feature/auth/presentation/signup_screen.dart';
import 'package:testflutter/helper/database_helper.dart';
import 'package:testflutter/helper/genLoginSignupHeader.dart';
import 'package:testflutter/helper/getTextFormField.dart';
import 'package:testflutter/helper/preference_helper.dart';
import 'package:testflutter/widgets/global_widget.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
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
      // LoginProvider loginProvider,
      // AccInqAllProvider inqAllAccountProvider,
      String username,
      String password) async {
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
      /// to do auth (login)
      // loginProvider.submitLogin(
      //     username, password, VarSession.fcmToken, inqAllAccountProvider);
      await dbHelper.getLoginUser(username, password).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
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

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      GlobalWidget.showAlertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      GlobalWidget.showAlertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
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

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    String data = '${user.user_id};${user.password}';
    preferencesHelper.setLoginAuth(data);
    sp.setString("user_id", user.user_id ?? '');
    sp.setString("user_name", user.user_name ?? '');
    sp.setString("email", user.email ?? '');
    sp.setString("password", user.password ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Signup'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('Login'),
                getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User ID'),
                const SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      width: 220,
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
                        onPressed: login,
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100,
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
                                _authenticateMe(data1, data2);
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
                      ElevatedButton(
                        // textColor: Colors.blue,
                        child: const Text('Signup'),
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
