import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

typedef StateEmitter = Emitter<NewsState>;

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  bool listenerAttached = false;
  final NewsRepository repository;

  NewsBloc(this.repository) : super(const NewsState()) {
    on<UpdateFeed>(_updateFeed);
    on<FetchFeeds>(_fetchFeeds);
  }

  void _updateFeed(UpdateFeed event, StateEmitter emit) {
    emit(state.copyWith(feed: event.feed));
  }

  void _fetchFeeds(FetchFeeds event, StateEmitter emit) async {
    emit(state.copyWith(loading: true));
    repository.fetchRSSfeed();
    if (!listenerAttached) {
      listenerAttached = true;
      await emit.forEach(
        repository.feedStream,
        onData: (data) {
          return state.copyWith(feed: data, loading: data == null);
        },
      );
    }
  }
}
