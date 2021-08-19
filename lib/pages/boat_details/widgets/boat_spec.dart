import 'package:flutter/material.dart';
import 'package:flutter_boats_challenge/constants.dart';

class BoatSpec extends StatelessWidget {
  const BoatSpec({
    Key key,
    @required this.t1,
    @required this.t2,
  }) : super(key: key);

  final String t1;
  final String t2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: padding,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              t1,
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(t2)),
        ],
      ),
    );
  }
}