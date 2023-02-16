// import 'dart:async';
// import 'package:testflutter/feature/login/model/user_model.dart';
// import 'package:testflutter/helper/database_helper.dart';

// class LoginCtr {
//   DbHelper con = DbHelper();
// //insertion
//   Future<int> saveUser(User user) async {
//     var dbClient = await con.db;
//     int res = await dbClient.insert("User", user.toMap());
//     return res;
//   }

//   //deletion
//   Future<int> deleteUser(User user) async {
//     var dbClient = await con.db;
//     int res = await dbClient.delete("User");
//     return res;
//   }

//   Future<User> getLogin(String user, String password) async {
//     var dbClient = await con.db;
//     var res = await dbClient.rawQuery(
//         "SELECT * FROM user WHERE username = '$user' and password = '$password'");

//     if (res.isNotEmpty) {
//       return User.fromMap(res.first);
//     }
//     return User.fromMap(null);
//   }

//   Future<List<User>> getAllUser() async {
//     var dbClient = await con.db;
//     var res = await dbClient.query("user");

//     List<User>? list =
//         res.isNotEmpty ? res.map((c) => User.fromMap(c)).toList() : null;
//     return list!;
//   }
// }
