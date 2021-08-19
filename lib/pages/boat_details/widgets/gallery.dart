import 'package:flutter/material.dart';
import 'package:flutter_boats_challenge/constants.dart';

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
