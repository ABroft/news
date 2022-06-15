import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:test_news/view/widgets/error_page.dart';
import 'package:test_news/view/widgets/news_loader.dart';
import 'package:test_news/view/widgets/news_body.dart';

import '../cubit/news_cubit.dart';
import 'news_item.dart';

class MainView extends StatelessWidget {
  MainView({Key? key}) : super(key: key);
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Новости"),
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state.status.isSuccess) {
              return SmartRefresher(
                enablePullDown: true,
                header: CustomHeader(
                  builder: (context, mode) {
                    Widget body;
                    if (mode == LoadStatus.loading) {
                      body = const NewsLoader(
                          maxIconSize: 50, durationMilliseconds: 1500);
                    } else {
                      body = const Text("Нет обновлений");
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: _refreshController,
                onRefresh: () {
                  BlocProvider.of<NewsCubit>(context).fetchNews();
                  _refreshController.refreshCompleted();
                },
                child: ListView.builder(
                    itemCount: state.newsList.length,
                    itemBuilder: (context, index) {
                      var newsItem = state.newsList[index];
                      return InkWell(
                        child: Card(
                            child: NewsBody(
                                isNewsItemPage: false, newsItem: newsItem)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    NewsItem(newsItem: newsItem)),
                          );
                        },
                      );
                    }),
              );
            } else if (state.status.isFailure) {
              return ErrorPage(
                refresh: () {
                  BlocProvider.of<NewsCubit>(context).fetchNews();
                },
                errorMessage: state.error,
              );
            } else {
              return Center(
                  child: NewsLoader(
                      maxIconSize: 100,
                      durationMilliseconds: 600,
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.5)));
            }
          },
        ),
      ),
    );
  }
}
