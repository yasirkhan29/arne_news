import 'dart:convert';
import 'package:arne_news/model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  List<NewsQueryModel> newsModelList = <NewsQueryModel>[];
  List<NewsQueryModel> newsModelListCarousel = <NewsQueryModel>[];

  bool isLoading = true;
  getNewsByQuery(String query) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=0ad78037ad7249c69b088a6ce9bf9fa7";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelList.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  getNewsofIndia() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=0ad78037ad7249c69b088a6ce9bf9fa7";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        NewsQueryModel newsQueryModel = new NewsQueryModel();
        newsQueryModel = NewsQueryModel.fromMap(element);
        newsModelListCarousel.add(newsQueryModel);
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getNewsByQuery("corona");
    getNewsofIndia();
  }

  @override
  Widget build(BuildContext context) {
     BannerAd bannerad = new BannerAd(size:  AdSize.banner, adUnitId: "ca-app-pub-3940256099942544/6300978111",
      listener:BannerAdListener(
      onAdLoaded: (ad) {
      print("Ad Loaded");
},

onAdFailedToLoad: (Ad ad, LoadAdError error){
print("Ad Failed");
ad.dispose();
},
        onAdOpened: (Ad ad){
        print("Ad Loaded");
        }
), request: AdRequest());
    return Scaffold(
      appBar: AppBar(
        title: const Text("U NEWS"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.2, 0.9],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(22.0),
                bottomRight: Radius.circular(20.0)),
            gradient: LinearGradient(
              colors: [Colors.white, Colors.blueAccent],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.2, 0.9],
            ),
          ),
          child: Column(
            children: [
              Container(
        child: AdWidget(
          ad: bannerad..load(),
          key: UniqueKey(),
        ),
        height: 50,
      ),
      const SizedBox( height: 24,),
              //search area
                
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if ((searchController.text).replaceAll(" ", "") == "") {
                          print("Blank search");
                        } else {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                        }
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Health"),
                      ),
                    )
                  ],
                ),
              ),
        
              // Top Bar
              
              Container(
                height: 80,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  scrollDirection: Axis.horizontal,
                  children: [
                    //pakistan
                    Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
                      child: InkWell(
                        child: const Center(
                          child:  Text('Pakistan',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://dailypakistan.com.pk')
                         
                      ),
                    ),
                    
                    const SizedBox( width: 24,),
                        //Live News
                      Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.1, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                         
                          child:  Text('. Live News',style: TextStyle(color: Colors.red,fontSize: 18,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.youtube.com/watch?v=sUKwTVAc0Vo')
                         
                      ),
                    ),
                      const SizedBox( width: 24,),
                    //world
                    Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
                      
                      child: InkWell(
                        child: const Center(
                          child:  Text('World',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.cgtn.com/world')
                         
                      ),
                    ),
                     const SizedBox( width: 24,),
                    // Entertainment
                     Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                          child:  Text('Entertainment',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.express.pk/saqafat/')
                         
                      ),
                    ),
                     const SizedBox( width: 24,),
                    //Technology
                      Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                          child:  Text('Technology',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.gadgets360.com/news')
                         
                      ),
                    ),
                    const SizedBox( width: 24,),
                     //Science
                      Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                          child:  Text('Science',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.gadgets360.com/science')
                         
                      ),
                    ),
                    const SizedBox( width: 24,),
                     //Business
                      Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                          child:  Text('Business',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.nytimes.com/international/section/business')
                         
                      ),
                    ),
                    const SizedBox( width: 24,),
                     //Sports
                      Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                          child:  Text('Sports',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.thenews.com.pk/latest/category/sports')
                         
                      ),
                    ),
                    const SizedBox( width: 24,),
                     //Health
                      Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                          child:  Text('Health',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.healthline.com/health-news')
                         
                      ),
                    ),
                   const SizedBox( width: 24,),
                    //News paper
                      Container(
                      width: 140,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0)),
                        gradient: LinearGradient(
                          colors: [Colors.white, Colors.blueAccent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          stops: [0.2, 0.9],
                        ),
                      ),
            
                      child: InkWell(
                        child: const Center(
                          child:  Text('News Paper',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight:FontWeight.bold),)),
                        onTap: () => launch('https://www.roznama92news.com/efrontend/web/index')
                         
                      ),
                    ),
                  
                  ],
                ),
              ),
              const SizedBox( height: 30,),

              //Carousel Slider bar

              Container(
                child: isLoading
                    ? Container(
                        height: 200,
                        child: Center(child: CircularProgressIndicator()))
                    : CarouselSlider(
                        options: CarouselOptions(
                            height: 200,
                            autoPlay: true,
                            enlargeCenterPage: true),
                        items: newsModelListCarousel.map((instance) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Stack(children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.network(
                                            instance.newsImg,
                                            fit: BoxFit.fitHeight,
                                            width: double.infinity,
                                          )),
                                      Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black12
                                                          .withOpacity(0),
                                                      Colors.black
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment
                                                        .bottomCenter)),
                                            child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5,
                                                    vertical: 10),
                                                child: Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10),
                                                    child: Text(
                                                      instance.newsHead,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ))),
                                          )),
                                    ])));
                          });
                        }).toList(),
                      ),
              ),
            //Latest news

              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(15, 25, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "LATEST NEWS ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: newsModelList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 1.0,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(
                                          newsModelList[index].newsImg,
                                          fit: BoxFit.fitHeight,
                                          height: 230,
                                          width: double.infinity,
                                        )),
                                    Positioned(
                                        left: 0,
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black12
                                                          .withOpacity(0),
                                                      Colors.black
                                                    ],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment
                                                        .bottomCenter)),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 15, 10, 8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  newsModelList[index].newsHead,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  newsModelList[index]
                                                              .newsDes
                                                              .length >
                                                          50
                                                      ? "${newsModelList[index].newsDes.substring(0, 55)}...."
                                                      : newsModelList[index]
                                                          .newsDes,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )))
                                  ],
                                )),
                          );
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  final List items = ["HELLO MAN", "NAMAS STAY", "DIRTY FELLOW"];
}
