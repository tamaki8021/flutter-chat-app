import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this._userName);
  final String _userName;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('チャットページ'),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemCount: 10,
                    itemBuilder: (_, int index) {})),
            Divider(
              height: 1.0,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0, right: 10, left: 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                      child: TextField(
                    decoration: InputDecoration.collapsed(hintText: "メッセージの送信"),
                  )),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
