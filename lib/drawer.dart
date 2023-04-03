import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ZoomDrawerController _controller = ZoomDrawerController();

  void _logout() {
    // Logout user
  }

  double getMediaQueryHeight(
      {required BuildContext context, required double value}) {
    return MediaQuery.of(context).size.height * (value / 100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Zoom Drawer'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Flutter Zoom Drawer!',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              FlatButton(
                onPressed: () {
                  _controller.toggle!();
                },
                child: Text('Open Drawer'),
              ),
            ],
          ),
        ),
      ),
      drawer: ZoomDrawer(
        controller: _controller,
        menuScreen: Drawer(
          backgroundColor: Color(0xff7d68f1),
          child: SafeArea(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 20),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image(
                            image: AssetImage('assets/download.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height:
                            getMediaQueryHeight(context: context, value: 10),
                      ),
                      Text('Ravi Patel',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Navigate to home screen
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    _logout();
                  },
                ),
              ],
            ),
          ),
        ),
        mainScreen: Container(
          child: Text('Main Screen'),
        ),
      ),
    );
  }
}
