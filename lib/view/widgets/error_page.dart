import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'news_loader.dart';

class ErrorPage extends StatelessWidget {
  ErrorPage({Key? key, String? errorMessage, required this.refresh})
      : errorMessage = errorMessage ?? "Сервер недоступен",
        super(key: key);

  final Function refresh;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final String errorMessage;
  final bool doIt = true;
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      header: CustomHeader(
        builder: (context, mode) {
          Widget body;
          if (mode == LoadStatus.loading) {
            body =
                const NewsLoader(maxIconSize: 50, durationMilliseconds: 1500);
          } else {
            body = Text(errorMessage);
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      onRefresh: () {
        refresh();
        _refreshController.refreshCompleted();
      },
      controller: _refreshController,
      child: ListView(
        children: [
          SizedBox(
              height: 250,
              child: Card(child: Center(child: Text(errorMessage)))),
        ],
      ),
    );
  }
}
