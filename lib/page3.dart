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
        return Text('Conectando...');
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
  late final allData;


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
                    child: SizedBox(width: 50, height: 50, child: Icon(Icons.search, color: Colors.white,)),
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
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w700,
              ),
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              tabs: <Widget>[
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
                FutureBuilder(
                  future: getData('Pequeña'),
                  builder: (context, snapshot) {
                  // Check for errors
                    if (snapshot.hasError) {
                      return Text("Algo salió mal, revise su conexión a internet");
                    }
                    // Once complete, show your application
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Text(allData[0]['name'].toString());
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
                const Center(
                  child: Text(
                    'KALTEGETRANKE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                ),
                const Center(
                  child: Text(
                    'HEIBGETRANKE',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
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
    print(allData);
  }
}
