import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:netflix/model/model_movie.dart';
import 'package:netflix/widget/box_slider.dart';
import 'package:netflix/widget/carousel_slider.dart';
import 'package:netflix/widget/circle_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget{
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> streamData;

  @override
  void initState(){
    super.initState();
    streamData = firestore.collection('movie').snapshots();
  }

  Widget _fetchData(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('movie').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot){
    List<Movie> movies = snapshot.map((d)=>Movie.fromSnapshot(d)).toList();

    return ListView(
      children: <Widget>[
        Stack(children: <Widget>[
          CarouselImage(movies: movies),
          TopBar(),
          ],
        ),
        CircleSlider(movies: movies),
        BoxSlider(movies: movies,),
      ],
    );
  }

  @override
  Widget build(BuildContext context){
    return _fetchData(context);
  }
}


class TopBar extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return Container(
      padding:EdgeInsets.fromLTRB(20,7,20,7),
      child: Row(                                             // 컨테이너 내의 child들을 횡으로 정렬
        mainAxisAlignment: MainAxisAlignment.spaceBetween,    // children 간의 간격 유지
        children: <Widget>[
        Image.asset(                       // 좌 상단 넷플릭스 로고
          'images/netflix_logo.png',
          fit: BoxFit.contain,
          height:25,
          ),
        Container(                          // 상단 TV 프로그램
          padding: EdgeInsets.only(right:1),
          child: Text(
            'TV 프로그램',
            style: TextStyle(fontSize:14), 
          )
        ),
        Container(                          // 상단 
          padding: EdgeInsets.only(right:1),
          child: Text(
            '영화',
            style: TextStyle(fontSize:14),
          )
        ),
        Container(                                // 우 상단
            padding: EdgeInsets.only(right:1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize:14),
            )
        ),
      ]),
    );
  }
}