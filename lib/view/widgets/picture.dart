import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'news_loader.dart';

class Picture extends StatelessWidget {
  const Picture(
      {Key? key,
      required this.url,
      required this.radius,
      this.fit,
      this.height,
      this.width,
      this.loaderMaxSize = 50,
      this.loaderDurationMillseconds = 1000})
      : super(key: key);

  final String url;
  final double radius;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double loaderMaxSize;
  final int loaderDurationMillseconds;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: CachedNetworkImage(
          imageUrl: url,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          placeholder: (context, url) => NewsLoader(
              maxIconSize: loaderMaxSize,
              durationMilliseconds: loaderDurationMillseconds),
          width: width,
          height: height,
          fit: fit,
        ));
  }
}
