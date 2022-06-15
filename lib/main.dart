import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:test_news/view/main_view.dart';

import 'cubit/news_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit(NewsRepository())
                 ..fetchNews() ,
      child: MaterialApp(
        title: 'News test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainView(),
      ),
    );
  }
}
