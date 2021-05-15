import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this._userName);
  final String _userName;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

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
                    controller: _controller,
                    onSubmitted: _handleSubmit,
                    decoration: InputDecoration.collapsed(hintText: "メッセージの送信"),
                  )),
                  Container(
                    child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.blue,
                      ),
                      onPressed: () {
                        _handleSubmit(_controller.text);
                      },
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

  _handleSubmit(String message) {
    _controller.text = "";
    var db = Firestore.instance;
    db.collection("chat_room").add({
      "user_name": widget._userName,
      "message": message,
      "created_at": DateTime.now(),
    }).then((value) {
      print("成功！！");
    }).catchError((e) {
      print(e);
    });
  }
}
