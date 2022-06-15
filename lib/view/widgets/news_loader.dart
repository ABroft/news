import 'package:flutter/material.dart';


class NewsLoader extends StatefulWidget {
  const NewsLoader(
      {Key? key,
      required this.maxIconSize,
      required this.durationMilliseconds,
      this.color = Colors.white})
      : super(key: key);
  final Color color;
  final int durationMilliseconds;
  final double maxIconSize;
  @override
  NewsLoaderState createState() => NewsLoaderState();
}

class NewsLoaderState extends State<NewsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.durationMilliseconds));

    _scaleAnimation = Tween(begin: 0.2, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _opacityAnimation = ReverseAnimation(_scaleAnimation);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Image.asset(
          'assets/logo.png',
          width: widget.maxIconSize,
          height: widget.maxIconSize,
          color: widget.color,
        ),
      ),
    );
  }
}
