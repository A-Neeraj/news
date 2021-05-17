class ArticleModel {
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String content;
  DateTime publishedAt;
  ArticleModel(
      {this.author,
      this.url,
      this.title,
      this.description,
      this.content,
      this.publishedAt,
      this.urlToImage});
}
