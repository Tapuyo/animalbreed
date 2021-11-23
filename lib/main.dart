import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:animalbreed/Dogmodel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );

  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future dog;
  List<DogBreed> myList = [];
  String sName = '';
  String sType = '';
  String sTemp = '';
  String sAgeLimit = '';
  String sImage = '';

  @override
  void initState() {
    myList = [];
    dog = getDog();
    super.initState();

  }
  Future<List<DogBreed>> getDog()async{
    final response = await http.get(Uri.parse('https://api.thedogapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=30'));
    var jsondata = json.decode(response.body);

    for (var u in jsondata){

      String name = '',type = '',temp = '',sa = '',ima = '';
      try{
        if(u['breeds'][0]['name'] != null){
          name = u['breeds'][0]['name'];
        }else{
          name = '';
        }
        if(u['breeds'][0]['breed_group'] != null){
          type = u['breeds'][0]['breed_group'];
        }else{
          type = '';
        }
        if(u['breeds'][0]['temperament'] != null){
          temp = u['breeds'][0]['temperament'];
        }else{
          temp = '';
        }
        if(u['breeds'][0]['life_span'] != null){
          sa = u['breeds'][0]['life_span'];
        }else{
          sa = '';
        }
        if(u['url']!= null){
          ima = u['url'];
        }else{
          ima = '';
        }
        String years = sa.replaceAll(new RegExp('years'),'');

        DogBreed nd = DogBreed(name, type, temp, years, ima);

        myList.add(nd);
      }catch(e){
        print("api error");
      }
    }
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xffEFEFEF),
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                        child: Stack(
                          children: [
                            Container(
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                image: DecorationImage(
                                  image: sImage == '' || sImage == null ? const AssetImage('assets/images/backdog.jpg'):NetworkImage(sImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 60, 0, 0),
                              child: Text(
                                'Dog Breed',
                                style: TextStyle(
                                  fontFamily: 'Helvetica Neue',
                                  fontSize: 27,
                                  color: const Color(0xffb4a9a9),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(20, 100, 0, 0),
                                child: Text(
                                  'Search your favorite pet \nBest for you',
                                  style: TextStyle(
                                    fontFamily: 'Helvetica Neue',
                                    fontSize: 15,
                                    color: const Color(0xffb4a9a9),
                                  ),
                                  textAlign: TextAlign.left,
                                )
                            )
                          ],
                        )
                    ),
                    SizedBox(height: 100,),
                    bodywidget(),

                  ],
                ),
              ),
              //insert card here
              Visibility(
                visible: sName != '',
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 270, 40, 20),
                  child: Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                sName,
                                style: TextStyle(
                                  fontFamily: 'Helvetica Neue',
                                  fontSize: 18,
                                  color: const Color(0xff050505),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                sType,
                                style: TextStyle(
                                  fontFamily: 'Helvetica Neue',
                                  fontSize: 16,
                                  color: const Color(0xff050505),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Text(
                                  sTemp,
                                  style: TextStyle(
                                    fontFamily: 'Helvetica Neue',
                                    fontSize: 14,
                                    color: const Color(0xffb4a9a9),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Text(
                                'Read more >',
                                style: TextStyle(
                                  fontFamily: 'Helvetica Neue',
                                  fontSize: 12,
                                  color: const Color(0xffb4a9a9),
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: sName != '',
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(40, 250, 45, 20),
                    child: Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13.0),
                            gradient: LinearGradient(
                              begin: Alignment(0.0, -1.0),
                              end: Alignment(0.0, 1.0),
                              colors: [const Color(0xfff300ff), const Color(0xff933e96)],
                              stops: [0.0, 1.0],
                            ),
                          ),
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Helvetica Neue',
                                  fontSize: 24,
                                  color: const Color(0xfff5f0f0),
                                ),
                                children: [
                                  TextSpan(
                                    text: sAgeLimit,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Years',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ),

                      ],
                    )
                  ),
                ),
              )
            ],


          ),
        )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: (){
          setState(() {
             sName = '';
             sType = '';
             sTemp = '';
             sAgeLimit = '';
             sImage = '';
             myList = [];
             dog = getDog();
          });
        },
        child: const Icon(Icons.home),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
    );
  }

  bodywidget(){
    return Container(
      height: 400,
      child: FutureBuilder(
          future: dog,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index){
                    if (snapshot.data != null) {

                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            sName = snapshot.data[index].Name;
                            sType = snapshot.data[index].Type;
                            sTemp = snapshot.data[index].Temp;
                            sAgeLimit = snapshot.data[index].AgeLimit;
                            sImage = snapshot.data[index].Image;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.4,
                                padding: EdgeInsets.fromLTRB(0, 280, 0, 0),
                                child: Container(
                                  height: 90,
                                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13.0),
                                    color: const Color(0xffffffff),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data[index].Name,
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue',
                                          fontSize: 18,
                                          color: const Color(0xff0a0a0a),
                                          fontWeight: FontWeight.w700,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        snapshot.data[index].Type,
                                        style: TextStyle(
                                          fontFamily: 'Helvetica Neue',
                                          fontSize: 14,
                                          color: const Color(0xff050505),
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: Container(
                                  height: 300,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data[index].Image),
                                      fit: BoxFit.cover,
                                    ),
                                    //border: Border.all(width: 1.0, color: const Color(0xff707070)),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    }else {
                      return Container(
                        child: Center(
                          child: Text('loading...'),
                        ),
                      );
                    }
                  }
              );
            }else{
              return Container();
            }

          }

      ),
    );
  }

}

