// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GyroscopeSensor extends StatefulWidget {
  const GyroscopeSensor({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<GyroscopeSensor> createState() => _GyroscopeSensorState();
}

class _GyroscopeSensorState extends State<GyroscopeSensor> {
  double x = 0, y = 0, z = 0;
  String direction = "none";

  @override
  void initState() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      print(event);

      x = event.x;
      y = event.y;
      z = event.z;

      //rough calculation, you can use
      //advance formula to calculate the orentation
      if (x > 0) {
        direction = "back";
      } else if (x < 0) {
        direction = "forward";
      } else if (y > 0) {
        direction = "left";
      } else if (y < 0) {
        direction = "right";
      }

      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Text(
            direction,
            style: const TextStyle(fontSize: 30),
          )
        ]));
  }
}
