import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Firebase'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton.icon(
                //e-mail ile giriss
                onPressed: () {},
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                label: Text('E-Mail Islemleri'),
                color: Colors.amber,
              ),
              RaisedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                label: Text('E-Mail Islemleri'),
                color: Colors.amber,
              )
            ],
          ),
        ),
      ),
    );
  }
}
