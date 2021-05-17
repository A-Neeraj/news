import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String newsUrl;

  const ArticleView({Key key, this.newsUrl}) : super(key: key);
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: WebView(
          initialUrl: widget.newsUrl,
          onWebViewCreated: ((WebViewController controller) {
            _completer.complete(controller);
          }),
        ),
      ),
    );
  }
}
