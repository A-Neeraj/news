// import 'package:all_in_one_news/helpers/news.dart';
// import 'package:all_in_one_news/models/article_model.dart';
// import 'package:flutter/material.dart';
//
// import 'article_view.dart';
//
// class VideoNews extends StatefulWidget {
//   @override
//   _VideoNewsState createState() => _VideoNewsState();
// }
//
// class _VideoNewsState extends State<VideoNews> {
//   List<ArticleModel> articles = new List<ArticleModel>();
//   bool loading = true;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getVideoNews();
//   }
//
//   getVideoNews() async {
//     VideoNewsClass vnews = VideoNewsClass();
//     await vnews.getVideoNews();
//     articles = vnews.varticles;
//     setState(() {
//       loading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.black87,
//         ),
//         body: Container(
//           // padding: EdgeInsets.only(top: 16),
//           child: loading
//               ? Center(
//                   child: Container(
//                     child: CircularProgressIndicator(),
//                   ),
//                 )
//               : Container(
//                   child: ListView.builder(
//                       shrinkWrap: true,
//                       physics: ClampingScrollPhysics(),
//                       itemCount: articles.length,
//                       itemBuilder: (context, index) {
//                         return Articles(
//                           imageUrl: articles[index].urlToImage,
//                           desc: articles[index].description,
//                           title: articles[index].title,
//                           year: articles[index].publishedAt.year.toString(),
//                           month: articles[index].publishedAt.month.toString(),
//                           day: articles[index].publishedAt.day.toString(),
//                           url: articles[index].url,
//                         );
//                       }),
//                 ),
//         ));
//   }
// }
//
// class Articles extends StatelessWidget {
//   final String imageUrl, title, desc, year, month, day, url;
//   Articles(
//       {this.imageUrl,
//       this.desc,
//       this.title,
//       this.year,
//       this.month,
//       this.day,
//       this.url});
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ArticleView(
//                       newsUrl: url,
//                     )));
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             SizedBox(
//               height: 100,
//               width: MediaQuery.of(context).size.width * 0.3,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   bottomLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                   bottomRight: Radius.circular(15),
//                 ),
//                 child: Image.network(
//                   imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.5,
//                   child: Text(
//                     title,
//                     maxLines: 2,
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.5,
//                   child: Text(
//                     desc,
//                     maxLines: 2,
//                     style: TextStyle(color: Colors.black54),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.calendar_today_outlined),
//                     Text(
//                       day + '-' + month + '-' + year,
//                       style: TextStyle(color: Colors.grey),
//                     )
//                   ],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//     // Column(
//     // children: [Image.network(imageUrl), Text(title), Text(desc)],
//     // );
//   }
// }

import 'package:all_in_one_news/screens/video_screen.dart';
import 'package:flutter/material.dart';

import '../helpers/api_service.dart';
import '../models/channel_model.dart';
import '../models/video_model.dart';

class VideoNews extends StatefulWidget {
  @override
  _VideoNewsState createState() => _VideoNewsState();
}

class _VideoNewsState extends State<VideoNews> {
  Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UC16niRr50-MSBwiO3YDb3RA');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Stack(children: [
                Image(
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(video.thumbnailUrl),
                  fit: BoxFit.fill,
                ),
                Center(
                  child: Icon(
                    Icons.play_arrow_rounded,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
            SizedBox(width: 10.0),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                video.title,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                DateTime.parse(video.publishedAt).toLocal().toString(),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 8.0, top: 15, right: 15.0),
              alignment: Alignment.centerLeft,
              child: Text(
                video.desc == null ? 'Hi' : video.desc,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Videos'),
        foregroundColor: Colors.black,
        // backgroundColor: Colors.black,
      ),
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollDetails) {
                if (!_isLoading &&
                    _channel.videos.length != int.parse(_channel.videoCount) &&
                    scrollDetails.metrics.pixels ==
                        scrollDetails.metrics.maxScrollExtent) {
                  _loadMoreVideos();
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 1 + _channel.videos.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return _buildProfileInfo(_channel.videos[0]);
                  }
                  if (index == 1) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10.0),
                      // padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, offset: Offset(1, 2))
                          ]),
                      child: Text(
                        'Information',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  Video video = _channel.videos[index - 1];
                  return _buildVideo(video);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor, // Red
                ),
              ),
            ),
    );
  }
}
