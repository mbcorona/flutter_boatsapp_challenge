import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Boats Challenge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class Boat {
  Boat({this.img, this.text, this.text2});
  final String img;
  final String text;
  final String text2;
}

final List<Boat> boats = [
  Boat(img: 'assets/boat1.png', text: 'X34 Force', text2: 'NeoKraft'),
  Boat(img: 'assets/boat2.png', text: 'Z24 Force', text2: 'NeoKraft'),
  Boat(img: 'assets/boat3.png', text: 'X54 No se', text2: 'NeoKraft'),
  Boat(img: 'assets/boat4.png', text: 'X54 Fun', text2: 'NeoKraft'),
];

const padding = 15.0;

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
          Hero(
            tag: "bg",
                      child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [.85, 1.0],
                  colors: [Colors.white, Colors.blue],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: padding,
              vertical: padding * 3,
            ),
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
                    onPressed: () {})
              ],
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
                  (1 - (value == 1.0 ? 1.0 : value * 2)).clamp(0.0, 1.0);
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
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text('By ${boat.text2}'),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return BoatDetails(
                    boat: boat,
                  );
                },
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("SPEC"),
              Icon(Icons.chevron_right_outlined),
            ],
          ),
        )
      ],
    );
  }
}

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
          FullSpec(size: size, boat: boat),
          buildShadow(size),
          buildBoatImg(size),
          buildCloseBtn(context),
        ],
      ),
    );
  }

  Widget buildShadow(Size size) {
    return Hero(
      tag: 'bg',
          child: Container(
        height: size.width - 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [.3, .75, 1.0],
            colors: [
              Colors.blue,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0),
            ],
          ),
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

class FullSpec extends StatelessWidget {
  const FullSpec({
    Key key,
    @required this.size,
    @required this.boat,
  }) : super(key: key);

  final Size size;
  final Boat boat;

  @override
  Widget build(BuildContext context) {
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
                    Gallery(),
                    Gallery(
                      title: "RELATED BOATS",
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Gallery extends StatelessWidget {
  const Gallery({
    Key key,
    this.title = "GALLERY",
  }) : super(key: key);

  final title;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: padding * 2),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              GalleryImage(
                size: size,
                img: 'assets/gallery.jpeg',
              ),
              GalleryImage(
                size: size,
                img: 'assets/gallery1.jpeg',
              ),
              GalleryImage(
                size: size,
                img: 'assets/gallery2.jpeg',
              ),
              GalleryImage(
                size: size,
                img: 'assets/gallery3.jpeg',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class GalleryImage extends StatelessWidget {
  const GalleryImage({
    Key key,
    @required this.size,
    @required this.img,
  }) : super(key: key);

  final Size size;
  final String img;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * .4,
      height: size.width * .3,
      margin: const EdgeInsets.only(right: padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(padding),
        image: DecorationImage(
          image: AssetImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

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
