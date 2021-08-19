import 'package:flutter/material.dart';
import 'package:flutter_boats_challenge/boat_model.dart';
import 'package:flutter_boats_challenge/pages/boat_details/boat_details.dart';

class BoatCard extends StatelessWidget {
  const BoatCard({
    Key key,
    @required this.boat,
  }) : super(key: key);

  final Boat boat;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: boat.text,
          child: Image.asset(
            boat.img,
            height: size.height * .6,
          ),
        ),
        Text(
          boat.text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'By ${boat.text2}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                reverseTransitionDuration: const Duration(milliseconds: 600),
                transitionDuration: const Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: BoatDetails(boat: boat),
                  );
                },
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SPEC",
                style: TextStyle(fontSize: 28),
              ),
              Icon(Icons.chevron_right_outlined),
            ],
          ),
        )
      ],
    );
  }
}