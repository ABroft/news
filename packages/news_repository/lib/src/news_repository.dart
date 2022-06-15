import 'dart:async';
import 'models/news.dart';
import 'package:news_api/news_api.dart' as api;

class NewsRepository {
  NewsRepository({
    api.NewsApi? newsApi,
  }) : _newsApi = newsApi ?? api.NewsApi();

  final api.NewsApi _newsApi;

  Future<List<News>> getNews(
      {String? schoolType = 'ballet', int? cityId = 1, int? count = 10}) async {
    List<News> list = <News>[];

    final iterableNews = await _newsApi
        .fetchNews(schoolType: schoolType!, cityId: cityId!, count: count!)
        .onError((error, stackTrace) {
      return error;
    });
    for (api.News apiNews in iterableNews) {
      if (apiNews.language == 'ru' || apiNews.language == null) {
        List<String> additionalImagePathsList = [];
        if (apiNews.additionalImagesPaths != null &&
            apiNews.additionalImagesPaths!.isNotEmpty) {
          for (var e in apiNews.additionalImagesPaths!) {
            String s = e as String;
            additionalImagePathsList.add(s);
          }
        }
        News news = News(
            id: apiNews.id ?? -1,
            title: apiNews.title ?? '',
            text: apiNews.text ?? '',
            dateTime: apiNews.dateTime ?? DateTime.now(),
            previewPath: apiNews.previewPath,
            mainImagePath: apiNews.mainImagePath,
            additionalImagesPaths: additionalImagePathsList);
        list.add(news);
      }
    }
    return list;
  }
}
