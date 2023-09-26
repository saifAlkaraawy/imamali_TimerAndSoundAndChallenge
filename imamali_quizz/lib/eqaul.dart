import 'package:flutter/material.dart';
import 'quiznew.dart';

class Equal extends StatefulWidget {
  const Equal({Key? key}) : super(key: key);

  @override
  State<Equal> createState() => _EqualState();
}

class _EqualState extends State<Equal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/backround2.jpg"),
              fit: BoxFit.cover,
            )),
            child: const Center(
              child: Text(
                "تعادل الفريقين",
                style: TextStyle(color: Colors.white, fontSize: 55.0),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Quiznew()));
            },
            icon: const Icon(Icons.refresh_sharp),
            iconSize: 30.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
