import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'newProviderqui.dart';
import 'newResult.dart';
import 'eqaul.dart';
import 'package:async/async.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';

class Quiznew extends StatefulWidget {
  const Quiznew({Key? key}) : super(key: key);

  @override
  State<Quiznew> createState() => _QuiznewState();
}

class _QuiznewState extends State<Quiznew> {
  bool oneTimeClick = true;
  int indeximage = 0;
  PageController? _controller;
  int scoreBlue = 0;
  int ScoreRed = 0;
  Color? selection;
  Color? colorCardBackround;
  bool colorCard = true;
  String? urlImage;
  int indexUlrImage = 0;
  int indexOut = 0;
  RestartableTimer? timer;
  Timer? subTimer;
  Timer? timerResult;
  //this opject i added to Text wight to make timer
  Duration duration = const Duration(seconds: 30);
  int secontTimerResult = 4;
  BuildContext? contextOut;
  bool oneTimeClickOnTimer = true;
  bool timerColorSelect = true;
  final warringPlayer = AudioPlayer();
  final heartPlayer = AudioPlayer();
  final pointPlayer = AudioPlayer();
  final failurePlayer = AudioPlayer();

  void startTimer(context) {
    timer = RestartableTimer(
      const Duration(seconds: 1),
      () {
        subTimer = Timer.periodic(const Duration(seconds: 1), (_) {
          addtimer(context);
        });
      },
    );
  }

  void addtimer(context) async {
    const addsecond = 1;
    setState(() {
      final second = duration.inSeconds - addsecond;

      duration = Duration(seconds: second);
      if (second == 10) {
        timerColorSelect = false;
      }

      if (second == 4) {
        warringPlayer.play();
      }

      if (second == 0) {
        subTimer!.cancel();
        setState(() {
          colorCard = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 0,
      viewportFraction: 1,
    );
    loadAssets();
  }

  void loadAssets() async {
    await warringPlayer.setAsset('sounds/warring.mp3');
    await heartPlayer.setAsset('sounds/drumRoll.mp3');
    await pointPlayer.setAsset('sounds/winTone.mp3');
    await failurePlayer.setAsset('sounds/failureTone.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("images/backround3.jpg"),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //timer
                      InkWell(
                        child: Text(
                          //this is timer
                          "${duration.inSeconds}",
                          style: TextStyle(
                              color: timerColorSelect == true
                                  ? Colors.amberAccent
                                  : Colors.red,
                              fontSize: 120.0),
                        ),
                        onTap: () async {
                          if (oneTimeClickOnTimer == true) {
                            startTimer(context);
                            oneTimeClickOnTimer = false;
                          }
                        },
                      ),
                      // Red Point
                      Row(
                        children: [
                          Image.asset(
                            "images/redGroupPoint.png",
                            fit: BoxFit.cover,
                            width: 150.0,
                            height: 150.0,
                          ),
                          Text(
                            ": $ScoreRed",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 70.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      //الحكم
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Buttons for group red
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //+++
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    ScoreRed = ScoreRed + 10;
                                  });
                                },
                                icon: const Icon(Icons.add_circle_sharp),
                                color: Colors.red,
                                iconSize: 60.0,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              //--

                              IconButton(
                                onPressed: () {
                                  if (ScoreRed > 0) {
                                    setState(() {
                                      ScoreRed = ScoreRed - 10;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.minimize),
                                color: Colors.red,
                                iconSize: 60.0,
                                padding: const EdgeInsets.all(0.0),
                              ),
                            ],
                          ),
                          Image.asset(
                            "images/referee.png",
                            width: 130.0,
                            height: 130.0,
                          ),

                          //Buttons for group blue
                          Column(
                            children: [
                              //+++
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    scoreBlue = scoreBlue + 10;
                                  });
                                },
                                icon: const Icon(Icons.add_circle_sharp),
                                color: Colors.blue,
                                iconSize: 60.0,
                              ),

                              //----
                              IconButton(
                                onPressed: () {
                                  if (scoreBlue > 0) {
                                    setState(() {
                                      scoreBlue = scoreBlue - 10;
                                    });
                                  }
                                },
                                icon: const Icon(Icons.minimize_rounded),
                                color: Colors.blue,
                                iconSize: 60.0,
                              ),
                            ],
                          )
                        ],
                      ),
                      //Blue Point
                      Row(
                        children: [
                          Image.asset(
                            "images/BlueGroupPoint.png",
                            fit: BoxFit.cover,
                            width: 150.0,
                            height: 150.0,
                          ),
                          Text(
                            ": $scoreBlue",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 70.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      indeximage >= 8
                          ? Image.asset(
                              "images/boxing.png",
                              fit: BoxFit.cover,
                              width: 600.0,
                              height: 700.0,
                            )
                          : Image.asset(
                              "${urlImageSelect(providerQuation[indexUlrImage].question!.keys.toList()[0] == 1)}",
                              fit: BoxFit.cover,
                              width: 600.0,
                              height: 700.0,
                            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SafeArea(
                          child: Row(
                            children: [
                              SizedBox(
                                  width: 1100,
                                  height: 800,
                                  child: pageViewQuation(context, _controller))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pageViewQuation(BuildContext context, controller) {
    contextOut = context;

    return PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        itemCount: providerQuation.length,
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          indexOut = index;

          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // الاسئلة
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: getColorCardBorder(
                            providerQuation[index].question!.keys.toList()[0]),
                        width: 8.0),
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.white,
                  ),
                  width: double.infinity,
                  height: 195.0,
                  margin: const EdgeInsets.all(25.0),
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    textDirection: TextDirection.rtl,
                    children: [
                      Flexible(
                        child: Center(
                          child: AutoSizeText(
                            providerQuation[index].question!.values.toList()[0],
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textDirection: TextDirection.rtl,
                            minFontSize: 55.0,
                            maxLines: 3,
                            maxFontSize: 70.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //الخيارات

                Container(
                  // color: Colors.green,
                  //تم اظافة هذة الكونتينر لزيادة عرض العامود
                  width: 700,
                  margin: const EdgeInsets.only(right: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (int i = 0;
                          i < providerQuation[index].answers!.length;
                          i++)
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 700,
                                height: 110,
                                child: InkWell(
                                  //logic for on tap
                                  onTap: () async {
                                    if (oneTimeClick == true &&
                                        duration.inSeconds != 0) {
                                      onTapCard(index, i);
                                      oneTimeClick = false;
                                    }
                                  },

                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: providerQuation[index]
                                                          .question!
                                                          .keys
                                                          .toList()[0] ==
                                                      1
                                                  ? Colors.blue
                                                  : Colors.red,
                                              width: 8.0)),
                                      color: colorCard == true
                                          ? Colors.white
                                          : selectColor(providerQuation[index]
                                              .answers!
                                              .values
                                              .toList()[i]),
                                      child: Center(
                                        child: Text(
                                          providerQuation[index]
                                              .answers!
                                              .keys
                                              .toList()[i],
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 40.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                //الزر التالي
                Container(
                    margin: const EdgeInsets.only(left: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            iconSize: 90,
                            icon: const Icon(Icons.reply_all),
                            color: Colors.white,
                            onPressed: () {
                              logicNextPage(
                                context: context,
                                controller: _controller,
                              );
                              // setState(() {
                              //   colorCard = true;
                              //   // duration = const Duration(seconds: 20);
                              // });
                            })
                      ],
                    )),
              ],
            ),
          );
        });
  }

  selectColor(bool color) {
    if (color == true) {
      return selection = Colors.green[400];
    } else {
      return selection = Colors.red[600];
    }
  }

  selectColorCard(bool wichGroub) {
    if (wichGroub == true) {
      return colorCardBackround = Colors.blue;
    } else {
      return colorCardBackround = Colors.red;
    }
  }

  urlImageSelect(bool url) {
    if (url == true) {
      return urlImage = "images/BlueGroup.png";
    } else {
      return urlImage = "images/RedGroup.png";
    }
  }

  void onTapCard(index, i) {
    //اذا كان الجواب صحيح للفريق الازرق
    if (providerQuation[index].answers!.values.toList()[i] &&
        providerQuation[index].question!.keys.toList()[0] == 1) {
      if (warringPlayer.playing) {
        warringPlayer.pause();
      }

      timer!.cancel();
      subTimer!.cancel();
      //song the drums
      heartPlayer.play();
      timerResult = Timer.periodic(const Duration(seconds: 1), (_) {
        secontTimerResult = secontTimerResult - 1;

        if (secontTimerResult == 0) {
          pointPlayer.play();
          setState(() {
            colorCard = false;
            scoreBlue += 20;
          });
          timerResult!.cancel();
          secontTimerResult = 4;
        }
      });
      // اذا كان الجواب الصحيح للفريق الاحمر
    } else if (providerQuation[index].answers!.values.toList()[i] &&
        providerQuation[index].question!.keys.toList()[0] == 2) {
      if (warringPlayer.playing) {
        warringPlayer.pause();
      }
      timer!.cancel();
      subTimer!.cancel();
      heartPlayer.play();
      timerResult = Timer.periodic(const Duration(seconds: 1), (_) {
        secontTimerResult = secontTimerResult - 1;

        if (secontTimerResult == 0) {
          pointPlayer.play();
          setState(() {
            colorCard = false;
            ScoreRed += 20;
          });
          timerResult!.cancel();
          secontTimerResult = 4;
        }
      });
    } else {
      if (warringPlayer.playing) {
        warringPlayer.pause();
      }
      timer!.cancel();
      subTimer!.cancel();
      heartPlayer.play();
      timerResult = Timer.periodic(const Duration(seconds: 1), (_) {
        secontTimerResult = secontTimerResult - 1;

        if (secontTimerResult == 0) {
          failurePlayer.play();
          setState(() {
            colorCard = false;
          });
          timerResult!.cancel();
          secontTimerResult = 4;
        }
      });
    }
  }

  void logicNextPage({controller, context}) {
    int winerScore;
    bool wichGroup;
    if (controller!.page?.toInt() == providerQuation.length - 1) {
      if (scoreBlue > ScoreRed) {
        winerScore = scoreBlue;
        wichGroup = true;

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NewResult(
                      score: winerScore,
                      wichGroup: wichGroup,
                    )));
      } else if (ScoreRed > scoreBlue) {
        winerScore = ScoreRed;
        wichGroup = false;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => NewResult(
                      score: winerScore,
                      wichGroup: wichGroup,
                    )));
      } else if (ScoreRed == scoreBlue) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Equal()));
      }

      if (timer != null) {
        timer!.cancel();
      }

      if (subTimer != null) {
        subTimer!.cancel();
      }

      subTimer!.cancel();
      if (timerResult != null) {
        timerResult!.cancel();
      }
    } else {
      setState(() {
        indeximage = controller!.page?.toInt();

        if (controller!.page?.toInt() >= 8) {
          duration = const Duration(seconds: 120);
        } else {
          duration = const Duration(seconds: 30);
        }
        colorCard = true;
        indexUlrImage = indexOut + 1;
        timerColorSelect = true;
      });

      oneTimeClick = true;
      oneTimeClickOnTimer = true;
      controller!.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInExpo);
      AudioPlayer.clearAssetCache();
      if (timer != null) {
        timer!.cancel();
      }
      subTimer!.cancel();
      if (timerResult != null) {
        timerResult!.cancel();
      }
    }
  }

  Color getColorCardBorder(int selector) {
    if (selector == 1) {
      return Colors.blue;
    } else if (selector == 2) {
      return Colors.red;
    } else if (selector == 3) {
      return Colors.amber;
    } else {
      return Colors.black;
    }
  }

  @override
  void dispose() {
    warringPlayer.dispose();
    heartPlayer.dispose();
    pointPlayer.dispose();
    failurePlayer.dispose();

    if (timer != null) {
      timer!.cancel();
    }
    if (subTimer != null) {
      subTimer!.cancel();
    }
    if (timerResult != null) {
      timerResult!.cancel();
    }

    super.dispose();
  }
}
