import 'dart:convert';

import 'package:all_in_one_news/models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> articles = [];
  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=758378290b8a4ead88db4759ac4cd7a9";
    var res = await http.get(Uri.parse(url));
    var json = jsonDecode(res.body);
    if (json['status'] == "ok") {
      json["articles"].forEach((article) {
        if (article["urlToImage"] != null && article["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: article["title"],
              author: article["author"],
              url: article['url'],
              description: article['description'],
              urlToImage: article['urlToImage'],
              publishedAt: DateTime.parse(article['publishedAt']));
          articles.add(articleModel);
        }
      });
    }
  }
}

class VideoNewsClass {
  List<ArticleModel> varticles = [];
  Future<void> getVideoNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=video&sortBy=popularity&language=en&apiKey=758378290b8a4ead88db4759ac4cd7a9";
    var res = await http.get(Uri.parse(url));
    var json = jsonDecode(res.body);
    if (json['status'] == "ok") {
      json["articles"].forEach((article) {
        if (article["urlToImage"] != null && article["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: article["title"],
              author: article["author"],
              url: article['url'],
              description: article['description'],
              urlToImage: article['urlToImage'],
              publishedAt: DateTime.parse(article['publishedAt']));
          varticles.add(articleModel);
        }
      });
    }
  }
}
