import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testflutter/feature/auth/model/user_model.dart';
import 'package:testflutter/feature/auth/presentation/login_screen.dart';
import 'package:testflutter/feature/home/home_screen.dart';
import 'package:testflutter/helper/database_helper.dart';
import 'package:testflutter/helper/navigation.dart';
import 'package:testflutter/helper/preference_helper.dart';
import 'package:testflutter/widgets/global_widget.dart';

class AuthController extends GetxController {
  var dbHelper = DbHelper();
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  PreferencesHelper preferencesHelper =
      PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());

  final formKey = GlobalKey<FormState>();
  final formLoginKey = GlobalKey<FormState>();

  final userIdCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final cPasswordCtrl = TextEditingController();

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;
    String data = '${user.email};${user.password}';
    preferencesHelper.setLoginAuth(data);
    sp.setString("user_id", user.user_id ?? '');
    sp.setString("usernaem", user.user_name ?? '');
    sp.setString("email", user.email ?? '');
    sp.setString("password", user.password ?? '');
  }

  login(String email, String password) async {
    if (email.isEmpty) {
      GlobalWidget.showAlertDialog(ctx, "Please Enter Email");
    } else if (password.isEmpty) {
      GlobalWidget.showAlertDialog(ctx, "Please Enter Password");
    } else {
      // log(email);
      await dbHelper.getLoginUser(email, password).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                ctx,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
                (Route<dynamic> route) => false);
          });
        } else {
          GlobalWidget.showAlertDialog(ctx, "Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        GlobalWidget.showAlertDialog(ctx, "Error: Login Fail");
      });
    }
  }

  signUp() async {
    String uid = userIdCtrl.text;
    String username = usernameCtrl.text;
    String email = emailCtrl.text;
    String passwd = passwordCtrl.text;
    String cpasswd = cPasswordCtrl.text;

    if (formKey.currentState!.validate()) {
      if (passwd != cpasswd) {
        GlobalWidget.showAlertDialog(ctx, 'Password Mismatch');
      } else {
        formKey.currentState!.save();

        UserModel uModel = UserModel(uid, username, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          GlobalWidget.showAlertDialog(ctx, "Successfully Saved");

          Navigator.push(ctx, MaterialPageRoute(builder: (_) => LoginForm()));
        }).catchError((error) {
          print(error);
          GlobalWidget.showAlertDialog(ctx, "Error: Data Save Fail");
        });
      }
    }
  }
}
