import 'package:flutter/material.dart';
import 'package:flutter_boats_challenge/boat_model.dart';
import 'package:flutter_boats_challenge/constants.dart';
import 'package:flutter_boats_challenge/pages/home/widgets/boat_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pg = PageController();
  var _currentPage = 0.0;

  onPageChange() {
    setState(() {
      _currentPage = _pg.page;
    });
  }

  @override
  void initState() {
    _pg.addListener(onPageChange);
    super.initState();
  }

  @override
  void dispose() {
    _pg.removeListener(onPageChange);
    _pg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [.8, .9, 1],
                colors: [Colors.white, Colors.blue.shade200, Colors.blue],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: padding * 3,
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Boats",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          PageView.builder(
            controller: _pg,
            itemCount: boats.length,
            itemBuilder: (context, index) {
              final boat = boats[index];
              final value = index < _currentPage
                  ? _currentPage - index
                  : index - _currentPage;
              final opacity =
                  (1 - (value == 1.0 ? 1.0 : value * 2)).clamp(0.25, 1.0);
              return Transform.scale(
                scale: opacity.clamp(0.85, 1.0),
                child: Opacity(
                  opacity: opacity,
                  child: BoatCard(boat: boat),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
