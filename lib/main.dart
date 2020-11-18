import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flip_card/flip_card.dart';


void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      accentColor: Color.fromRGBO(205, 220, 57, 1),
      primaryColor: Color.fromRGBO(63, 81, 181, 1),
      primaryColorDark: Color.fromRGBO(48, 63, 159, 1),
      primaryColorLight: Color.fromRGBO(197, 202, 233, 1),
      //primaryTextTheme:,
    ),
    home: CardGame(),
  ));
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
  List<String> data = [];
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
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
    }
    for (var i = 0; i < widget.size ~/ 2; i++) {
      data.add(i.toString());
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
                data: ThemeData.dark(),
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
                        margin: EdgeInsets.all(4.0),
                        color: Color.fromRGBO(63, 81, 181, 1),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        color: Color.fromRGBO(48, 63, 159, 1),
                        child: Center(
                          child: Text(
                            "${data[index]}",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                      ),
                    ),
                    itemCount: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Display Results
  showResult() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Congrats"),
        content: Text(
          "Time $time",
          style: Theme.of(context).textTheme.headline2,
        ),
        actions: <Widget>[
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
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }
}