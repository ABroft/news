import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/parser.dart';
import 'package:test_news/view/widgets/gallery.dart';
import 'package:test_news/view/widgets/picture.dart';

import '../../models/news.dart';

class NewsBody extends StatelessWidget {
  const NewsBody(
      {Key? key, required this.isNewsItemPage, required this.newsItem})
      : super(key: key);
  final bool isNewsItemPage;
  final News newsItem;
  @override
  Widget build(BuildContext context) {
    final String? pictureUrl =
        (isNewsItemPage) ? newsItem.mainImagePath : newsItem.previewPath;
    final DateTime d = newsItem.dateTime;
    final Widget text = (isNewsItemPage)
        ? Html(data: newsItem.text)
        : Text(
            parse(parse(newsItem.text).body?.text).documentElement?.text ?? '');
    final List<String>? urlList = newsItem.additionalImagesPaths;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (!isNewsItemPage || urlList == null || urlList.isEmpty)
                ? (pictureUrl != null)
                    ? Picture(
                        url: pictureUrl,
                        radius: 5,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      )
                    : const SizedBox.shrink()
                : Gallery(urlList: urlList),
            Container(
                padding: const EdgeInsets.only(left: 6, top: 4),
                child: Text('${d.day}.${d.month}.${d.year}')),
            Container(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  newsItem.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                )),
            const SizedBox(
              height: 8,
            ),
            text,
          ]),
    );
  }
}
