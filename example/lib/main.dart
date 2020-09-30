import 'package:flutter/material.dart';
import 'package:resizable_window/resizable_window.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ResizableWindowView(
          hasAppbar: true,
          leftChild: SingleChildScrollView(
            child: Container(
              color: Colors.deepOrangeAccent,
              height: 600,
            ),
          ),
          topRightChild: ListView(
            children: [
              Container(
                color: Colors.green,
                height: 100,
              ),
              Container(
                color: Colors.black,
                height: 200,
              ),
            ],
          ),
          bottomRightChild: ListView(
            children: [
              Container(
                color: Colors.indigoAccent,
                height: 300,
              ),
              Container(
                color: Colors.deepOrangeAccent,
                height: 300,
              ),
              Container(
                color: Colors.pink,
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
