import 'package:flutter/material.dart';
import '../constants.dart';

class TwoColumn extends StatelessWidget {
  // kendi widget mi yaratiyoruz.
  final IconData icon;
  final double size;
  final Color color;
  final String text;

  TwoColumn({
    @required this.icon, //icon ve text zorunlu olmalidir aksi halde hata verir
    this.color,
    this.size,
    @required this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: size,
          color: color,
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          text,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}
