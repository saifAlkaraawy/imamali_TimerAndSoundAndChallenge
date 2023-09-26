import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'quiznew.dart';

class NewResult extends StatefulWidget {
  int score;
  bool? wichGroup;
  String? urlImage;
  NewResult({required this.score, required this.wichGroup, Key? key})
      : super(key: key);

  @override
  NewResultState createState() => NewResultState();
}

class NewResultState extends State<NewResult> {
  ConfettiController? controller;
  String? urlImage;
  final celebrate = AudioPlayer();
  @override
  void initState() {
    super.initState();

    controller = ConfettiController(duration: const Duration(seconds: 2000));
    controller!.play();
    // loadAssets();
    // play();
  }

  void loadAssets() async {
    await celebrate.setAsset("sounds/celebrate.mp3");
  }

  void play() {
    celebrate.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/backroundImageWiner.jpg"),
            fit: BoxFit.cover,
          )),
        ),
        Center(
          child: Image.asset(
            widget.wichGroup == true
                ? "images/BlueGroupWinner.png"
                : "images/RedGroupWinner.png",
            fit: BoxFit.contain,
            width: 850.0,
            height: 850.0,
          ),
        ),
        buildConfettiRight(),
        buildConfettileft(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Quiznew()));
              },
              icon: const Icon(Icons.refresh_sharp),
              iconSize: 50.0,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 25),
              child: Row(
                children: [
                  Image.asset(
                    "images/cup.png",
                    width: 150.0,
                    height: 150.0,
                  ),
                  Text(
                    "${widget.score}",
                    style: TextStyle(color: Colors.amber[500], fontSize: 70),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    ));
  }

  Widget buildConfettiRight() => Container(
        margin: const EdgeInsets.only(left: 300.0),
        child: Align(
          alignment: Alignment.topLeft,
          widthFactor: double.infinity,
          child: ConfettiWidget(
            confettiController: controller,
            shouldLoop: true,
            numberOfParticles: 5,
//emissionDuration

            colors: const [
              Colors.red,
              Colors.blue,
              Colors.orange,
              Colors.purple,
              Colors.lightBlue,
              Colors.green,
            ],
            //blastDirection: blastDirection,
          ),
        ),
      );

  Widget buildConfettileft() => Align(
        alignment: Alignment.topRight,
        widthFactor: double.infinity,
        child: ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          numberOfParticles: 5,
//emissionDuration

          colors: const [
            Colors.red,
            Colors.blue,
            Colors.orange,
            Colors.purple,
            Colors.lightBlue,
          ],
          //blastDirection: blastDirection,
        ),
      );

  urlImageSelect(bool url) {
    if (url == true) {
      return urlImage = "images/BlueGroup.png";
    } else {
      return urlImage = "images/RedGroup.png";
    }
  }

  @override
  void dispose() {
    controller!.dispose();
    celebrate.dispose();
    super.dispose();
  }
}
