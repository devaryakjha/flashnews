import 'package:flashnews/features/news/bloc/news_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/domain/rss_feed.dart';

class NewsRepository {
  final feedStreamController = BehaviorSubject<RssFeed?>.seeded(null);

  ValueStream<RssFeed?> get feedStream => feedStreamController.stream;

  void fetchRSSfeed() async {
    final feeds = await NewsService.instance.fetchRSSfeed();
    feedStreamController.sink.add(feeds);
  }
}
