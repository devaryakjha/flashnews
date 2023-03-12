part of 'news_bloc.dart';

class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpdateFeed extends NewsEvent {
  final RssFeed feed;

  UpdateFeed(this.feed);
}

class FetchFeeds extends NewsEvent {}
