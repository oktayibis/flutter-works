import 'package:flutter/material.dart';
import '../constants.dart';

class CircleIconButton extends StatefulWidget {
  IconData icon;
  Function clicked;
  CircleIconButton({@required this.icon, this.clicked});
  @override
  _CircleIconButtonState createState() => _CircleIconButtonState();
}

class _CircleIconButtonState extends State<CircleIconButton> {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      shape: CircleBorder(),
      fillColor: kButtonBackgroundColor,
      padding: EdgeInsets.all(10.0),
      child: Icon(
        widget.icon,
        size: 30.0,
        color: Colors.white,
      ),
      elevation: 5.0,
      onPressed: widget.clicked,
    );
  }
}
