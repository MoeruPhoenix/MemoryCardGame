/*import 'dart:ui';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';*/

/*class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}*/

/*class _homeState extends State<home> {
  int time = 0;
  Timer timer;
  startTimer(){
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        time = time = 1;
      });
    });

  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      "$time",
                    style: Theme.of(context).textTheme.display2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                      ),
                    itemBuilder: (context,index)=>FlipCard(
                      onFlip: () {

                      },
                      direction: FlipDirection.HORIZONTAL,
                      flipOnTouch: true,
                      front: Container(
                        margin: EdgeInsets.all(4.0),
                        //backgroundImage: AssetImage('images/hiddenbackgorund.jpg'),
                        color: Color.fromRGBO(63, 81, 181, 0.3),
                      ),
                      back: Container(
                        margin: EdgeInsets.all(4.0),
                        //backgorundImage: AssetImage('images/hiddenbackgorund.jpg'),
                        color: Color.fromRGBO(63, 81, 181, 0.3),
                      ),
                    ),
                    itemCount: 12,
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}*/

