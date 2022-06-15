import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/news.dart';
import 'package:news_repository/news_repository.dart' as rep;

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(
    this._newsRepository,
  ) : super(const NewsState());

  final rep.NewsRepository _newsRepository;

  Future<void> fetchNews() async {
    emit(state.copyWith(status: NewsStatus.loading));

    try {
      var list = await _newsRepository.getNews();
      List<News> newsList = _toNews(repList: list);

      emit(state.copyWith(
        status: NewsStatus.success,
        newsList: newsList,
      ));
    } catch (e) {
      emit(state.copyWith(status: NewsStatus.failure, error: e.toString()));
    }
  }

  List<News> _toNews({required List<rep.News> repList, List<News>? newList}) {
    newList ??= [];
    for (var n in repList) {
      List<String>? urlList = n.additionalImagesPaths;
      if (urlList != null && urlList.isNotEmpty && n.mainImagePath != null) {
        urlList.insert(0, n.mainImagePath!);
      }
      News newsItem = News(
        id: n.id,
        title: n.title,
        text: n.text,
        dateTime: n.dateTime,
        previewPath: n.previewPath,
        mainImagePath: n.mainImagePath,
        additionalImagesPaths: urlList,
      );
      newList.add(newsItem);
    }
    return newList;
  }
}
