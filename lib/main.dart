import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleComputationPage(),
    ),
  );
}

class SimpleComputationPage extends StatefulWidget {
  @override
  _SimpleComputationPageState createState() => _SimpleComputationPageState();
}

class _SimpleComputationPageState extends State<SimpleComputationPage> {
  List<String> operations = ["+", "-", "*"];
  int leftNum = 1;
  int rightNum = 1;
  int operationNum = 0;
  int answer = 0;
  int result = 2;
  String dropdownValue = 'Level one';

  TextEditingController userInput = TextEditingController();
  void update() {
    setState(() {
      if (dropdownValue == 'Level one') {
        leftNum = Random().nextInt(10) + 1;
        rightNum = Random().nextInt(10) + 1;
      } else if (dropdownValue == 'Level two') {
        leftNum = Random().nextInt(50) + 1;
        rightNum = Random().nextInt(50) + 1;
      } else {
        leftNum = Random().nextInt(100) + 1;
        rightNum = Random().nextInt(100) + 1;
      }

      operationNum = Random().nextInt(3);
      result = correctAnswer(operations[operationNum]);
    });
  }

  int correctAnswer(String str) {
    int result = 0;

    if (str == "+") {
      result = leftNum + rightNum;
    } else if (str == "-") {
      result = leftNum - rightNum;
    } else if (str == "*") {
      result = leftNum * rightNum;
    }

    return result;
  }

  Future<void> _showDialog() async {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text('Incorrect!', textAlign: TextAlign.center),
          content: new Text('This is the correct answer: ' + result.toString()),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                update();
                userInput.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Basic Math Operations')),
        backgroundColor: Colors.green,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(
                  Icons.arrow_downward,
                  color: Colors.white,
                ),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                    update();
                  });
                },
                items: <String>[
                  'Level one',
                  'Level two',
                  'Level three',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: Colors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        leftNum.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        operations[operationNum],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        rightNum.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        "=",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 35.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0,
              width: 300,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Container(
              width: 140,
              color: Colors.white,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    answer = int.parse(userInput.text);
                  });
                },
                child: TextFormField(
                  controller: userInput,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    isDense: true,
                    //contentPadding: EdgeInsets.all(0), //or any padding you want
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                  ),
                  // ignore: missing_return
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
              width: 300,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Container(
              color: Colors.white,
              child: FlatButton(
                onPressed: () {
                  // ignore: missing_return
                  setState(() {
                    answer = int.parse(userInput.text);

                    if (answer != result) {
                      _showDialog();
                    } else {
                      update();
                      userInput.clear();
                    }
                  });
                },
                child: Text(
                  "Submit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
