import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'article_view.dart';

class SavedNews extends StatefulWidget {
  final String uid;

  const SavedNews({Key key, this.uid}) : super(key: key);
  @override
  _SavedNewsState createState() => _SavedNewsState();
}

class _SavedNewsState extends State<SavedNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(widget.uid)
            .collection('liked')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              if (snapshot.hasData) {
                return Container(
                  child: ListView(
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      return SavedArticles(
                        imageUrl: document['imageUrl'],
                        desc: document['desc'],
                        title: document['title'],
                        year: document['year'],
                        month: document['month'],
                        day: document['day'],
                        url: document['url'],
                        uid: widget.uid,
                      );
                    }).toList(),
                  ),
                );
              } else {
                return Scaffold(body: Text('You did not save any news yet'));
              }
          }
        },
      ),
    );
  }
}

class SavedArticles extends StatelessWidget {
  final String imageUrl, title, desc, year, month, day, url, uid;
  SavedArticles(
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
                        icon: Icon(Icons.bookmark),
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
