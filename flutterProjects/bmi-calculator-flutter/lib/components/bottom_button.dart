import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String buttonLabel;
  final Function onTap;

  BottomButton({@required this.buttonLabel, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEA1455),
      width: double.infinity,
      height: 80,
      padding: EdgeInsets.only(bottom: 10.0),
      child: FlatButton(
        padding: EdgeInsets.only(bottom: 10.0),
        onPressed: onTap,
        child: Text(
          buttonLabel,
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, letterSpacing: 2.0),
        ),
      ),
    );
  }
}
