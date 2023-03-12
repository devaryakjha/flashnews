// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsDescription extends StatelessWidget {
  const NewsDescription({
    Key? key,
    required this.item,
  }) : super(key: key);

  final RssItem item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: item.source?.value != null ? Text(item.source!.value!) : null,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          if (await canLaunchUrlString(item.link!)) {
            launchUrlString(item.link!);
          } else {
            debugPrint('Link not supported');
          }
        },
        label: const Text('View original article'),
        icon: const Icon(Icons.open_in_new),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title!,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(DateFormat().add_yMMMMEEEEd().format(item.pubDate!)),
            Expanded(
              child: Html(
                data: item.description,
                onLinkTap: (url, context, attributes, element) async {
                  if (url == null) return;
                  if (await canLaunchUrlString(url)) {
                    launchUrlString(url);
                  }
                },
                style: {
                  'body': Style(
                    fontSize: const FontSize(13),
                  ),
                  'li': Style(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
