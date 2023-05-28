import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MediaQuery(data: MediaQueryData(), child: MaterialApp(home: MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int leftImageNumber = 1;
  int rightImageNumber = 1;
  int numberOfTries = 0;
  int winCount = 0;
  String? winner;

  void randImage() {
    numberOfTries += 1;
    leftImageNumber = Random().nextInt(3) + 1;
    rightImageNumber = Random().nextInt(3) + 1;
  }

  void getTheWinner(int leftImageNumber, int rightImageNumber) {
    if (leftImageNumber == rightImageNumber)
      winner = "none";
    else if ((leftImageNumber == 1 && rightImageNumber == 2) ||
        (leftImageNumber == 2 && rightImageNumber == 3) ||
        (leftImageNumber == 3 && rightImageNumber == 1)) {
      winCount++;
      winner = "you";
    } else {
      winner = "System";
    }

    print(numberOfTries);
    print(winCount);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Rock Paper Scissors "),
      //   backgroundColor: Colors.transparent,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage("images/image$leftImageNumber.png"),
                      ),
                      onPressed: () {
                        setState(() {
                          randImage();
                          getTheWinner(leftImageNumber, rightImageNumber);
                          if (numberOfTries >= 12) {
                            _showDialog();
                          }
                        });
                      },
                    ),
                    Text(
                      "YOU",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Text(
                  "vs",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          randImage();
                          getTheWinner(leftImageNumber, rightImageNumber);
                          if (numberOfTries >= 12) {
                            _showDialog();
                          }
                        });
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage("images/image$rightImageNumber.png"),
                      ),
                    ),
                    Text(
                      "SYSTEM",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            winner != null
                ? Text(
                    "the winner : $winner",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Your Score'),
          content: Text('You win $winCount times of  $numberOfTries times'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((value) {
      setState(() {
        numberOfTries = 0;
        winCount = 0;
      });
    });
  }
}
