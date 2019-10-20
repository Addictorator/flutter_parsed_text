import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'example_app',
      home: MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ParsedText(
              alignment: TextAlign.start,
              text:
                  "[@michael:51515151] Hello london this is an example of the ParsedText, links like http://www.google.com or http://www.facebook.com are clickable and phone number 444-555-6666 can call too. But you can also do more with this package, for example Bob will change style and David too.\nAlso a US number example +1-(800)-831-1117. foo@gmail.com And the magic number is 42! #flutter #flutterdev",
              parse: <MatchText>[
                MatchText(
                    pattern: r"\[(@[^:]+):([^\]]+)\]",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                    ),
                    renderText: ({String str, String pattern}) {
                      Match match = RegExp(pattern).firstMatch(str);
                      return {'display' : match.group(1), 'value' : match.group(2)};
                    },
                    onTap: (url) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text("Mentions clicked"),
                            content: new Text("$url clicked."),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {},
                              ),
                            ],
                          );
                        },
                      );
                    }),
                MatchText(
                    pattern: r"\B#+([\w]+)\b",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 24,
                    ),
                    onTap: (url) async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: new Text("Hashtag clicked"),
                            content: new Text("$url clicked."),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text("Close"),
                                onPressed: () {},
                              ),
                            ],
                          );
                        },
                      );
                    }),
                MatchText(
                    pattern: r"lon",
                    style: TextStyle(
                      color: Colors.pink,
                      fontSize: 24,
                    ),
                    onTap: (url) async {})
              ],
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }
}
