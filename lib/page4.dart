import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plantamas/widget/custom_banner_ad.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Page4());
}

class Page4 extends StatelessWidget {
  Page4({Key? key}) : super(key: key);
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Algo salió mal, revise su conexión a internet");
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyPage4(title: 'Title');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: Text('Conectando...'));
      },
    );
  }
}

class MyPage4 extends StatefulWidget {
  const MyPage4({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyPage4State createState() => _MyPage4State();
}

class _MyPage4State extends State<MyPage4> with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
  final CategoriesScroller categoriesScroller = CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  late TabController _tabController;
  dynamic allData;
  dynamic allData2;

  dynamic allSmall;
  dynamic allMedium;
  dynamic allBig;

  void initState() {
    // initialise your tab controller here
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height * 0.30;
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: size.height,
              child: Column(
                children: [
                  const CustomBannerAd(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "\n¿Quieres recibir algun consejo?",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: closeTopContainer ? 0 : 1,
                    child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: size.width,
                        alignment: Alignment.topCenter,
                        height: closeTopContainer ? 0 : categoryHeight,
                        child: categoriesScroller),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Consejos",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      //weatherBox(_weather)
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            hintText: 'Buscar',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _textController.clear();
                              },
                              icon: Icon(Icons.clear),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        flex: 9,
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.blue, // button color
                          child: InkWell(
                            splashColor: Colors.blue.shade50, // inkwell color
                            child: const SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                )),
                            onTap: () {},
                          ),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.blue,
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      unselectedLabelColor: Colors.grey,
                      unselectedLabelStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700,
                      ),
                      labelStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                      tabs: const <Widget>[
                        Text('Plantas'),
                        Text('Plagas'),
                        Text('Macetas'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        //Small tab
                        FutureBuilder(
                          future: getData('plantas'),
                          builder: (context, snapshot) {
                            // Check for errors
                            if (snapshot.hasError) {
                              return const Text(
                                  "Algo salió mal, revise su conexión a internet");
                            }
                            // Once complete, show your application
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView.builder(
                                itemCount: allData.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(15),
                                      elevation: 10,
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 10, 25, 0),
                                            title: Text(allSmall[0]['title']
                                                .toString()),
                                            subtitle: Text(
                                                allSmall[0]['type'].toString()),
                                            leading: Icon(Icons.grass),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            // Otherwise, show something whilst waiting for initialization to complete
                            return Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 150,
                            ));
                          },
                        ),
                        //Medium Plants
                        FutureBuilder(
                          future: getData('plagas'),
                          builder: (context, snapshot) {
                            // Check for errors
                            if (snapshot.hasError) {
                              return const Text(
                                  "Algo salió mal, revise su conexión a internet");
                            }
                            // Once complete, show your application
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView.builder(
                                itemCount: allData.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(15),
                                      elevation: 10,
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 10, 25, 0),
                                            title: Text(allMedium[0]['title']
                                                .toString()),
                                            subtitle: Text(allMedium[0]['type']
                                                .toString()),
                                            leading: Icon(Icons.bug_report),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            // Otherwise, show something whilst waiting for initialization to complete
                            return Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 150,
                            ));
                          },
                        ),

                        //Big Plants
                        FutureBuilder(
                          future: getData('macetas'),
                          builder: (context, snapshot) {
                            // Check for errors
                            if (snapshot.hasError) {
                              return const Text(
                                  "Algo salió mal, revise su conexión a internet");
                            }
                            // Once complete, show your application
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return ListView.builder(
                                itemCount: allData.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(15),
                                      elevation: 10,
                                      child: Column(
                                        children: <Widget>[
                                          ListTile(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                15, 10, 25, 0),
                                            title: Text(
                                                allBig[0]['title'].toString()),
                                            subtitle: Text(
                                                allBig[0]['type'].toString()),
                                            leading: Icon(Icons.agriculture),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            // Otherwise, show something whilst waiting for initialization to complete
                            return Center(
                                child: LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.blue,
                              size: 150,
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }

  late final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('consejos');

  Future<void> getData(String size) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await _collectionRef.where('type', isEqualTo: size).get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (size == 'plantas') {
      allSmall = querySnapshot.docs.map((doc) => doc.data()).toList();
    }
    if (size == 'plagas') {
      allMedium = querySnapshot.docs.map((doc) => doc.data()).toList();
    }
    if (size == 'macetas') {
      allBig = querySnapshot.docs.map((doc) => doc.data()).toList();
    }

    print(allData);
  }

  Future<void> getData2(String size) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await _collectionRef.where('fav', isEqualTo: size).get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (size == 'true') {
      allSmall = querySnapshot.docs.map((doc) => doc.data()).toList();
    }
    if (size == 'false') {
      allMedium = querySnapshot.docs.map((doc) => doc.data()).toList();
    }

    print(allData);
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 102, 143, 93),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Plantas",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Ver mas",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Image.asset(
                          "assets/images/planta.png",
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  print("cambio1");
                },
              ),
              GestureDetector(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 193, 207, 110),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Plagas",
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Ver mas",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Image.asset(
                            "assets/images/planta.png",
                            height: 70,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  print("cambio2");
                },
              ),
              GestureDetector(
                child: Container(
                  width: 150,
                  margin: EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 19, 163, 0),
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Macetas",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Ver Mas",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Image.asset(
                          "assets/images/planta.png",
                          height: 70,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  print("cambio3");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
