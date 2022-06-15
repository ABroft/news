part of 'news_cubit.dart';

enum NewsStatus {
  initial,
  loading,
  success,
  failure,
}

extension NewsStatusG on NewsStatus {
  bool get isInitial => this == NewsStatus.initial;
  bool get isLoading => this == NewsStatus.loading;
  bool get isSuccess => this == NewsStatus.success;
  bool get isFailure => this == NewsStatus.failure;
}

class NewsState extends Equatable {
  const NewsState(
      {this.status = NewsStatus.initial, this.newsList = const [], this.error});

  final NewsStatus status;
  final List<News> newsList;
  final String? error;

  NewsState copyWith({
    NewsStatus? status,
    List<News>? newsList,
    String? error,
  }) {
    return NewsState(
      status: status ?? this.status,
      newsList: newsList ?? this.newsList,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        status,
      ];
}
