// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'news_bloc.dart';

class NewsState extends Equatable {
  final RssFeed? feed;
  final bool loading;

  const NewsState({this.feed, this.loading = false});

  NewsState copyWith({
    RssFeed? feed,
    bool? loading,
  }) {
    return NewsState(
      feed: feed ?? this.feed,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [feed, loading];
}
