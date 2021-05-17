class Video {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;
  final String publishedAt;
  final String desc;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
    this.publishedAt,
    this.desc,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    print(snippet['description']);
    return Video(
        id: snippet['resourceId']['videoId'],
        title: snippet['title'],
        thumbnailUrl: snippet['thumbnails']['high']['url'],
        channelTitle: snippet['channelTitle'],
        publishedAt: snippet['publishedAt'],
        desc: snippet['description']);
  }
}
