import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:avatar_glow/avatar_glow.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      accentColor: Color.fromRGBO(205, 220, 57, 1),
      primaryColor: Color.fromRGBO(63, 81, 181, 1),
      primaryColorDark: Color.fromRGBO(48, 63, 159, 1),
      primaryColorLight: Color.fromRGBO(197, 202, 233, 1),
      //primaryTextTheme:,
    ),
    home: Home(),
  ));
}

class PlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      startDelay: Duration(milliseconds: 1000),
      glowColor: Color.fromRGBO(197, 202, 233, 1),
      endRadius: 160.0,
      duration: Duration(milliseconds: 2000),
      repeat: true,
      showTwoGlows: true,
      repeatPauseDuration: Duration(milliseconds: 500),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CardGame()),
          );
        },

        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(160.0)),
          child: Text(
            "Start",
            style: TextStyle(
                fontSize: 75.0,
                fontWeight: FontWeight.w800,
                color: Color.fromRGBO(0, 0, 0, 1)),
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 190.0),
              child: Text(
                "Memory Card Game",
                style: Theme.of(context).textTheme.headline3,

              ),
            ),
            PlayButton()
          ],
        ),
      ),
    );
  }
}

class CardGame extends StatefulWidget {
  final int size;

  const CardGame({Key key, this.size = 12}) : super(key: key);
  @override
  _CardGameState createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  List<bool> cardFlips = [];
  List<String> data = [
    'images/java.jpg',
    'images/java.jpg',
    'images/php.jpg',
    'images/php.jpg',
    'images/html.png',
    'images/html.png',
    'images/css.jpg',
    'images/css.jpg',
    'images/js.png',
    'images/js.png',
    'images/kotlin.jpg',
    'images/kotlin.jpg',
  ];

  int previousIndex = -1;
  bool flip = false;

  int time = 0;
  Timer timer;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.size; i++) {
      cardStateKeys.add(GlobalKey<FlipCardState>());
      cardFlips.add(true);
    }
    startTimer();
    data.shuffle();
  }

  startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time + 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Memory Card Game'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "$time",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Theme(
                data: ThemeData.dark(
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) => FlipCard(
                      key: cardStateKeys[index],
                      onFlip: () {
                        if (!flip) {
                          flip = true;
                          previousIndex = index;
                        } else {
                          flip = false;
                          if (previousIndex != index) {
                            if (data[previousIndex] != data[index]) {
                              cardStateKeys[previousIndex]
                                  .currentState
                                  .toggleCard();
                              previousIndex = index;
                            } else {
                              cardFlips[previousIndex] = false;
                              cardFlips[index] = false;

                              if (cardFlips.every((t) => t == false)) {
                                showResult();
                              }
                            }
                          }
                        }
                      },

                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: cardFlips[index],
                      front: Container(
                        decoration: BoxDecoration(
                          //color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10
                            )
                        ),
                        margin: EdgeInsets.all(1.0),
                        child: new Padding(
                          padding: const EdgeInsets.all(1.0
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/hiddenbackgorund.jpg'
                                      ),
                                      fit: BoxFit.fill)
                              )
                          ),
                        ),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        child: Center(
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage("${data[index]}"
                                      ),
                                      fit: BoxFit.fill)
                              )
                          ),
                        ),
                      ),
                    ),
                    itemCount: data.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool won = false;
  //Display Results
  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Winner!!"
        ),
        content: Text(
          "Time $time",
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              won = false;
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => CardGame(
                    size: 12,
                  ),
                ),
              );
            },
            child: Text("Play Again"
            ),
          ),
        ],
      ),
    );
  }
}