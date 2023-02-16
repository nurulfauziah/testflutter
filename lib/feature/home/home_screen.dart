// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';

import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Dashboard"),
//         actions: const [],
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(10.0),
//           child: Column(
//             children: [
//               Row(
//                 children: [Text(DateFormat('hh:mm:ss').format(DateTime.now()))],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _timeString;
  String? _tanggal;
  String? _currentAddress = '';
  Position? _currentPosition;
  String? batteryLevelStr;

  final Battery _battery = Battery();

  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    Position positionTets = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print("Current Position: ${positionTets.latitude}");
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      log("${position.latitude}lat");
      _getAddressFromLatLng(position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            "${place.street?.toString()}, ${place.subAdministrativeArea}";
        log('${place.street}'.toString());
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    _handleLocationPermission();
    _getCurrentPosition();
    log(_currentPosition?.latitude.toString() ?? '' "init lat");
    _battery.batteryState.then(_updateBatteryState);
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen(_updateBatteryState);
    getBaterry();
    super.initState();
  }

  void _updateBatteryState(BatteryState state) {
    if (_batteryState == state) return;
    setState(() {
      _batteryState = state;
    });
  }

  Future<void> getBaterry() async {
    final batteryLevel = await _battery.batteryLevel;
    batteryLevelStr = batteryLevel.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Column(
            children: [
              Text('$_batteryState'),
              Row(
                children: [
                  // const Icon(Icons.search, size: 25, color: Colors.black),
                  SizedBox(
                    width: 300,
                    child: Text(
                      _currentAddress.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Icon(Icons.location_on_outlined,
                      size: 20, color: Colors.black),
                ],
              ),
            ],
          ),
          // actions: const [
          //   Padding(
          //     padding: EdgeInsets.all(8.0),
          //     child: Icon(
          //       Icons.menu,
          //       color: Colors.black,
          //     ),
          //   )
          // ],
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('lat : ' '${_currentPosition?.latitude}, '),
                      Text('long : ' '${_currentPosition?.longitude}'),
                      Text('Battery: $batteryLevelStr%'),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: [
                      Text('$_tanggal : $_timeString'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    dynamic currentTime = DateFormat.jm().format(DateTime.now());

    setState(() {
      _timeString = currentTime;
      _tanggal = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMEd().format(dateTime);

    // return DateFormat('MM/dd/yyyy').format(dateTime);
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
  }
}





// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:testflutter/feature/login/model/user_model.dart';
// import 'package:testflutter/helper/database_helper.dart';
// import 'package:testflutter/helper/getTextFormField.dart';

// class HomeForm extends StatefulWidget {
//   @override
//   _HomeFormState createState() => _HomeFormState();
// }

// class _HomeFormState extends State<HomeForm> {
//   final _formKey = GlobalKey<FormState>();
//   final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

//   DbHelper? dbHelper;
//   final _conUserId = TextEditingController();
//   final _conDelUserId = TextEditingController();
//   final _conUserName = TextEditingController();
//   final _conEmail = TextEditingController();
//   final _conPassword = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     getUserData();

//     dbHelper = DbHelper();
//   }

//   Future<void> getUserData() async {
//     final SharedPreferences sp = await _pref;

//     setState(() {
//       _conUserId.text = sp.getString("user_id") ?? '';
//       _conDelUserId.text = sp.getString("user_id") ?? '';
//       _conUserName.text = sp.getString("user_name") ?? '';
//       _conEmail.text = sp.getString("email") ?? '';
//       _conPassword.text = sp.getString("password") ?? '';
//     });
//   }

//   // update() async {
//   //   String uid = _conUserId.text;
//   //   String uname = _conUserName.text;
//   //   String email = _conEmail.text;
//   //   String passwd = _conPassword.text;

//   //   if (_formKey.currentState!.validate()) {
//   //     _formKey.currentState!.save();

//   //     UserModel user = UserModel(uid, uname, email, passwd);
//   //     await dbHelper.updateUser(user).then((value) {
//   //       if (value == 1) {
//   //         alertDialog(context, "Successfully Updated");

//   //         updateSP(user, true).whenComplete(() {
//   //           Navigator.pushAndRemoveUntil(
//   //               context,
//   //               MaterialPageRoute(builder: (_) => LoginForm()),
//   //               (Route<dynamic> route) => false);
//   //         });
//   //       } else {
//   //         alertDialog(context, "Error Update");
//   //       }
//   //     }).catchError((error) {
//   //       print(error);
//   //       alertDialog(context, "Error");
//   //     });
//   //   }
//   // }

//   // delete() async {
//   //   String delUserID = _conDelUserId.text;

//   //   await dbHelper.deleteUser(delUserID).then((value) {
//   //     if (value == 1) {
//   //       GlobalWidget.showAlertDialog(context, "Successfully Deleted");

//   //       updateSP(null, false).whenComplete(() {
//   //         Navigator.pushAndRemoveUntil(
//   //             context,
//   //             MaterialPageRoute(builder: (_) => LoginForm()),
//   //             (Route<dynamic> route) => false);
//   //       });
//   //     }
//   //   });
//   // }

//   Future updateSP(UserModel user, bool add) async {
//     final SharedPreferences sp = await _pref;

//     if (add) {
//       sp.setString("user_name", user.user_name ?? '');
//       sp.setString("email", user.email ?? '');
//       sp.setString("password", user.password ?? '');
//     } else {
//       sp.remove('user_id');
//       sp.remove('user_name');
//       sp.remove('email');
//       sp.remove('password');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             margin: const EdgeInsets.only(top: 20.0),
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   //Update
//                   getTextFormField(
//                       controller: _conUserId,
//                       isEnable: false,
//                       icon: Icons.person,
//                       hintName: 'User ID'),
//                   const SizedBox(height: 10.0),
//                   getTextFormField(
//                       controller: _conUserName,
//                       icon: Icons.person_outline,
//                       inputType: TextInputType.name,
//                       hintName: 'User Name'),
//                   const SizedBox(height: 10.0),
//                   getTextFormField(
//                       controller: _conEmail,
//                       icon: Icons.email,
//                       inputType: TextInputType.emailAddress,
//                       hintName: 'Email'),
//                   const SizedBox(height: 10.0),
//                   getTextFormField(
//                     controller: _conPassword,
//                     icon: Icons.lock,
//                     hintName: 'Password',
//                     isObscureText: true,
//                   ),
//                   const SizedBox(height: 10.0),
//                   Container(
//                     margin: const EdgeInsets.all(30.0),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: const Text(
//                         'Update',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),

//                   //Delete

//                   getTextFormField(
//                       controller: _conDelUserId,
//                       isEnable: false,
//                       icon: Icons.person,
//                       hintName: 'User ID'),
//                   const SizedBox(height: 10.0),
//                   const SizedBox(height: 10.0),
//                   Container(
//                     margin: const EdgeInsets.all(30.0),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(30.0),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: () {},
//                       child: const Text(
//                         'Delete',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
