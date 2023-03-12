import 'package:dio/dio.dart';
import 'package:webfeed/domain/rss_feed.dart';

class NewsService {
  final Dio _dio = Dio();

  NewsService._();

  static NewsService get instance => NewsService._();

  Future<RssFeed?> fetchRSSfeed() async {
    try {
      final response = await _dio.get("https://news.google.com/rss");
      return RssFeed.parse(response.data);
    } catch (e) {
      return null;
    }
  }
}
