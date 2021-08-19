import 'package:flutter/material.dart';
import 'package:flutter_boats_challenge/boat_model.dart';
import 'package:flutter_boats_challenge/constants.dart';
import 'package:flutter_boats_challenge/pages/boat_details/widgets/boat_spec.dart';
import 'package:flutter_boats_challenge/pages/boat_details/widgets/gallery.dart';

class BoatDetails extends StatelessWidget {
  const BoatDetails({Key key, @required this.boat}) : super(key: key);

  final Boat boat;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          buildSpecs(size, context),
          buildShadow(size),
          buildBoatImg(size),
          buildCloseBtn(context),
        ],
      ),
    );
  }

  SingleChildScrollView buildSpecs(Size size, BuildContext context) {
    return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(padding),
            child: TweenAnimationBuilder(
              duration: Duration(milliseconds: 900),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (_, value, __) {
                final trans = Curves.elasticOut.transform(value);
                return Opacity(
                  opacity: value,
                  child: Transform(
                    transform: Matrix4.identity()..scale(1.0, trans),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.width - 70,
                        ),
                        Text(
                          boat.text,
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'By ${boat.text2}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: padding * 2,
                          ),
                          child: Text(
                            "Meet the highest-performing inboard\nwaterski boat ever created",
                          ),
                        ),
                        Text(
                          "SPEC",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        BoatSpec(t1: "Boat length", t2: "24\""),
                        BoatSpec(t1: "Beam", t2: "104\""),
                        BoatSpec(t1: "Weight", t2: "2345 Kg"),
                        BoatSpec(t1: "Fuel Capacity", t2: "250 L"),
                        Gallery(title: "GALLERY"),
                        Gallery(title: "RELATED BOATS"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
  }

  Widget buildShadow(Size size) {
    return Container(
      height: size.width - 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [.1, .3, .8, 1.0],
          colors: [
            Colors.blue,
            Colors.blue.shade200,
            Colors.white.withOpacity(0.5),
            Colors.white.withOpacity(0),
          ],
        ),
      ),
    );
  }

  Positioned buildBoatImg(Size size) {
    return Positioned(
      right: 40,
      child: Hero(
        tag: boat.text,
        child: Transform.rotate(
          angle: 3 * 3.1416 / 2,
          child: Image.asset(
            boat.img,
            height: size.width,
          ),
        ),
        flightShuttleBuilder: (
          BuildContext flightContext,
          Animation<double> animation,
          HeroFlightDirection flightDirection,
          BuildContext fromHeroContext,
          BuildContext toHeroContext,
        ) {
          final Hero toHero = fromHeroContext.widget;
          final Hero fromHero = fromHeroContext.widget;

          return RotationTransition(
            turns: flightDirection == HeroFlightDirection.push
                ? animation.drive(Tween(begin: 0.0, end: -.25))
                : animation.drive(Tween(begin: .25, end: 0)),
            child: flightDirection == HeroFlightDirection.push
                ? toHero.child
                : fromHero.child,
          );
        },
      ),
    );
  }

  Positioned buildCloseBtn(BuildContext context) {
    return Positioned(
      left: padding,
      top: padding * 4,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.close,
            color: Colors.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
