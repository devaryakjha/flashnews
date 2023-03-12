import 'package:flashnews/common/router/router.dart';
import 'package:flashnews/features/news/bloc/news_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: state.feed?.title != null ? Text(state.feed!.title!) : null,
          ),
          body: state.loading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async {
                    context.read<NewsBloc>().add(FetchFeeds());
                  },
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      final item = state.feed!.items![index];
                      return Padding(
                        padding: index == 0
                            ? const EdgeInsets.only(top: 16)
                            : EdgeInsets.zero,
                        child: ListTile(
                          title: item.title != null
                              ? Text(
                                  item.title!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : null,
                          subtitle: item.source?.value != null
                              ? Text(item.source!.value!)
                              : null,
                          onTap: () {
                            context.push(Routes.description, extra: item);
                          },
                          trailing: IconButton(
                            onPressed: () async {
                              if (await canLaunchUrlString(item.link!)) {
                                launchUrlString(item.link!);
                              } else {
                                debugPrint('Link not supported');
                              }
                            },
                            icon: const Icon(Icons.open_in_new),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: state.feed?.items?.length ?? 0,
                  ),
                ),
        );
      },
    );
  }
}
