import 'package:flutter/material.dart';
import 'package:test_news/view/widgets/news_body.dart';
import '../models/news.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({Key? key, required this.newsItem}) : super(key: key);

  final News newsItem;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              newsItem.title,
              maxLines: 2,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          body: SingleChildScrollView(
              child: NewsBody(isNewsItemPage: true, newsItem: newsItem)),
        ),
      ),
    );
  }
}
