import 'package:all_in_one_news/helpers/news.dart';
import 'package:all_in_one_news/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'article_view.dart';
import 'profile.dart';
import 'video.dart';

class MyHomePage extends StatefulWidget {
  final String uid;

  const MyHomePage({Key key, this.uid}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ArticleModel> articles = new List<ArticleModel>();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      getNews();
      getCurrentUser();
    });
  }

  getNews() async {
    News news = News();
    await news.getNews();
    articles = news.articles;
    setState(() {
      loading = false;
    });
  }

  User currentUser;
  void getCurrentUser() async {
    currentUser = await FirebaseAuth.instance.currentUser;
  }

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
        ),
        drawer: Drawer(
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ListTile(
                  title: Text('Home'),
                  onTap: () {},
                ),
                Divider(),
                ListTile(
                  title: Text('Video'),
                  onTap: () async {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => VideoNews()));
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Profile()));
                  },
                ),
                Divider(),
              ],
            ),
          ),
        ),
        body: loading
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                // padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return Articles(
                        imageUrl: articles[index].urlToImage,
                        desc: articles[index].description,
                        title: articles[index].title,
                        year: articles[index].publishedAt.year.toString(),
                        month: articles[index].publishedAt.month.toString(),
                        day: articles[index].publishedAt.day.toString(),
                        url: articles[index].url,
                        uid: currentUser.uid,
                      );
                    }),
              ));
  }
}

class Articles extends StatelessWidget {
  final String imageUrl, title, desc, year, month, day, url, uid;
  Articles(
      {this.imageUrl,
      this.desc,
      this.title,
      this.year,
      this.month,
      this.day,
      this.url,
      this.uid});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      newsUrl: url,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.3,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    title,
                    maxLines: 2,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    desc,
                    maxLines: 2,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.calendar_today_outlined),
                      Text(
                        day + '-' + month + '-' + year,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Category',
                        style: TextStyle(
                            backgroundColor: Colors.deepOrange,
                            color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.bookmark_border_outlined),
                        onPressed: () {
                          if (uid != null) {
                            FirebaseFirestore.instance
                                .collection("users")
                                .doc(uid)
                                .collection('liked')
                                .add({
                              'imageUrl': imageUrl,
                              'title': title,
                              'desc': desc,
                              'year': year,
                              'month': month,
                              'day': day,
                              'url': url,
                            }).catchError((err) => print(err));
                          } else {
                            print('Need to Login');
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
    // Column(
    // children: [Image.network(imageUrl), Text(title), Text(desc)],
    // );
  }
}
