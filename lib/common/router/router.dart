import 'package:flashnews/features/news/bloc/news_bloc.dart';
import 'package:flashnews/features/news/presentation/views/news.dart';
import 'package:flashnews/features/news/presentation/views/news_description.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:webfeed/domain/rss_item.dart';

class Routes {
  static const String home = '/news';
  static const String description = '/description';
}

final routerConfig = GoRouter(
  initialLocation: Routes.home,
  routes: [
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final bloc = context.read<NewsBloc>();
        if (bloc.state.feed == null) {
          context.read<NewsBloc>().add(FetchFeeds());
        }
        return const News();
      },
    ),
    GoRoute(
      path: Routes.description,
      builder: (context, state) {
        context.read<NewsBloc>().add(FetchFeeds());
        return NewsDescription(item: state.extra as RssItem);
      },
    ),
  ],
);
