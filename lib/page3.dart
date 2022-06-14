import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Page3());
}

class Page3 extends StatelessWidget {

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
          return MyPage3(title: 'Title');
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(
            child: Text('Conectando...')
        );
      },
    );
  }
}

class MyPage3 extends StatefulWidget{
  const MyPage3({Key? key, required this.title}): super(key: key);

  final String title;

  @override
  _Mypage3State createState() => _Mypage3State();
}

class _Mypage3State extends State<MyPage3> with SingleTickerProviderStateMixin{

  final _textController = TextEditingController();
  late TabController _tabController;
  dynamic allData;
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

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 40.0),
                    hintText: 'Buscar',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(onPressed: () {
                      _textController.clear();
                    }, icon: Icon(Icons.clear), color: Colors.blue,),
                  ),
                ),
                flex: 9,
              ),
              Expanded(

                child: Material(
                  color: Colors.blue, // button color
                  child: InkWell(
                    splashColor: Colors.blue.shade50, // inkwell color
                    child: const SizedBox(width: 50, height: 50, child: Icon(Icons.search, color: Colors.white,)),
                    onTap: () {},
                  ),
                ),
                flex: 1,
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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
                Text('Pequeño'),
                Text('Mediano'),
                Text('Grande'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                //Small tab
                FutureBuilder(
                  future: getData('Pequeña'),
                  builder: (context, snapshot) {
                  // Check for errors
                    if (snapshot.hasError) {
                      return const Text("Algo salió mal, revise su conexión a internet");
                    }
                    // Once complete, show your application
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: allData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Column(
                                children: <Widget>[
                                ListTile(
                                  contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                  title: Text(allSmall[0]['name'].toString()),
                                  subtitle: Text(allSmall[0]['genre'].toString()),
                                  leading: Icon(Icons.grass),
                                ),
                                ],
                              ),
                              ),);
                        },
                      );
                    }
                    // Otherwise, show something whilst waiting for initialization to complete
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue,
                          size: 150,
                        )
                      );
                  },
                ),
                //Medium Plants
                FutureBuilder(
                  future: getData('Mediana'),
                  builder: (context, snapshot) {
                    // Check for errors
                    if (snapshot.hasError) {
                      return const Text("Algo salió mal, revise su conexión a internet");
                    }
                    // Once complete, show your application
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: allData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                    title: Text(allMedium[0]['name'].toString()),
                                    subtitle: Text(allMedium[0]['genre'].toString()),
                                    leading: Icon(Icons.grass),
                                  ),
                                ],
                              ),
                            ),);
                        },
                      );
                    }
                    // Otherwise, show something whilst waiting for initialization to complete
                    return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue,
                          size: 150,
                        )
                    );
                  },
                ),

                //Big Plants
                FutureBuilder(
                  future: getData('Grande'),
                  builder: (context, snapshot) {
                    // Check for errors
                    if (snapshot.hasError) {
                      return const Text("Algo salió mal, revise su conexión a internet");
                    }
                    // Once complete, show your application
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: allData.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 0),
                                    title: Text(allBig[0]['name'].toString()),
                                    subtitle: Text(allBig[0]['genre'].toString()),
                                    leading: Icon(Icons.grass),
                                  ),
                                ],
                              ),
                            ),);
                        },
                      );
                    }
                    // Otherwise, show something whilst waiting for initialization to complete
                    return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.blue,
                          size: 150,
                        )
                    );
                  },
                ),
              ],
            ),
          ),

        ],
      ),

    );

  }


  late final CollectionReference _collectionRef = FirebaseFirestore.instance.collection('plantas');

  Future<void> getData(String size) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.where('size', isEqualTo: size).get();

    // Get data from docs and convert map to List
    allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    if(size == 'Pequeña'){
      allSmall = querySnapshot.docs.map((doc) => doc.data()).toList();
    }
    if(size == 'Mediana'){
      allMedium = querySnapshot.docs.map((doc) => doc.data()).toList();
    }
    if(size == 'Grande'){
      allBig = querySnapshot.docs.map((doc) => doc.data()).toList();
    }

    print(allData);
  }
}
