import 'package:flutter/material.dart';

class genLoginSignupHeader extends StatelessWidget {
  String headerName;

  genLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 50.0),
          Text(
            headerName,
            style: const TextStyle(
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
          const Text(
            'Sample Code',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                fontSize: 25.0),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
