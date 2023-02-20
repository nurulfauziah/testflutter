import 'package:flutter/material.dart';
import 'package:testflutter/helper/navigation.dart';

class MainAppbar extends StatefulWidget {
  final String title;
  final String? subTitle;
  final String? image;
  final List<Widget>? action;
  const MainAppbar(
      {Key? key, required this.title, this.action, this.subTitle, this.image})
      : super(key: key);

  @override
  _MainAppbarState createState() => _MainAppbarState();
}

class _MainAppbarState extends State<MainAppbar>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () => Navigation.back(),
        child: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Row(
        children: [
          Image.asset(widget.image ?? 'assets/seputar_bandung.png'),
          const SizedBox(
            width: 16.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                widget.subTitle ?? '',
                style: const TextStyle(fontSize: 10.0, color: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }
}
