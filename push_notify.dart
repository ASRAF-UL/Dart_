import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebasePushMessaging extends StatefulWidget {
  FirebasePushMessaging() : super();

  final String title = 'Sigmind.ai';
  @override
  State<StatefulWidget> createState() => FirebasePushMessagingState();
}

class FirebasePushMessagingState extends State<FirebasePushMessaging> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> messageList;
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("Device Token: $deviceToken");
    });
  }

  _configureFirebaseListeners() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
      _setMessage(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
      _setMessage(message);
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
      _setMessage(message);
    });
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = notification['title'];
    final String body = notification['body'];
    String mMessage = data['Message'];
    print("Title: $title, Body: $body, Message: $mMessage");
    setState(() {
      Message mssg = Message(title, body, mMessage);
      messageList.add(mssg);
    });
  }

  @override
  void initState() {
    super.initState();
    messageList = List<Message>();
    _getToken();
    _configureFirebaseListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.custom_blue,
        title: Text(
          widget.title,
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.normal,
              color: Colors.white.withOpacity(0.7)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.qr_code_scanner,
                color: Colors.white.withOpacity(0.7)),
            tooltip: 'Scanner',
            onPressed: null,
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white.withOpacity(0.7)),
          tooltip: 'Navigation menu',
          onPressed: null, // null disables the button
        ),
      ),
      body: ListView.builder(
        itemCount: null == messageList ? 0 : messageList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                messageList[index].message == null
                    ? ''
                    : messageList[index].message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.custom_blue,
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.custom_blue,
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: new Text('Home',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.white.withOpacity(0.7))),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.camera_rear,
              color: Colors.white,
            ),
            title: new Text(
              'Devices',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.7)),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.mail,
              color: Colors.white,
            ),
            title: new Text(
              'Messages',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.7)),
            ),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: new Text(
              'Me',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.white.withOpacity(0.7)),
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
