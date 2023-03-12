import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'common/router/router.dart';
import 'features/news/bloc/news_bloc.dart';
import 'features/news/bloc/news_repository.dart';

class FlashNews extends StatelessWidget {
  const FlashNews({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsRepository(),
      child: BlocProvider(
        create: (c) => NewsBloc(c.read<NewsRepository>()),
        child: MaterialApp.router(
          routerConfig: routerConfig,
        ),
      ),
    );
  }
}
