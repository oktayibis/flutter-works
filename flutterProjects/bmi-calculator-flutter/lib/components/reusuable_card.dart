import 'package:flutter/material.dart';

class ReusuableCard extends StatelessWidget {
  //devamli tekrar etmemek icin kendi widget olustrduk
  final Widget child;
  final Color color;
  final Color activeColor;
  Function onTap;
  ReusuableCard({
    @required this.color,
    this.child,
    this.activeColor,
    this.onTap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10.0)),
        margin: EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
