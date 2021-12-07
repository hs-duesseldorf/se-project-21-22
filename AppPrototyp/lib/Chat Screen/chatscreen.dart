import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

final StreamController<ChatMessageModel> _chatMessagesStreamController =
StreamController<ChatMessageModel>.broadcast();
final Stream<ChatMessageModel> _chatMessagesStream =
    _chatMessagesStreamController.stream;

const Color primaryColor = Color(0xFFFF3D00);
const Color secondaryColor = Color(0xFFFFF3E0);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Screen',
      home: ChatScreen(),
    );
  }
}

class ChatMessageModel {
  final String? message;

  const ChatMessageModel({
    this.message,
  });

  factory ChatMessageModel.turnSnapshotIntoListRecord(Map data) {
    return ChatMessageModel(
      message: data['message'],
    );
  }

  List<Object> get props => [
    message!,
  ];
}

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen9';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();

  String? _userInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Lerngruppe HöMa',
                style: GoogleFonts.bangers(
                  fontSize: 35,
                ),
                //),
              ),
            )
          ],
        ),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ThirdScreen()),
            );
          },
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: primaryColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      onChanged: (value) {
                        _userInput = value;
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        hintText: 'Deine Antwort...',
                        // border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _messageTextController.clear();

                      debugPrint(
                          'Adding a ChatMessageModel with the message $_userInput to the Stream');

                      ChatMessageModel chatMessageModelRecord =
                      ChatMessageModel(message: _userInput);

                      _chatMessagesStreamController.add(
                        chatMessageModelRecord,
                      );
                    },
                    child: Text(
                      'Senden',
                      style: GoogleFonts.lato(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ThirdScreen() {}
}



class MessagesStream extends StatefulWidget {
  @override
  _MessagesStreamState createState() => _MessagesStreamState();
}

class _MessagesStreamState extends State<MessagesStream> {
  final List<ChatMessageModel> _allMessagesContainedInTheStream = [];

  @override
  void initState() {
    _chatMessagesStream.listen((streamedMessages) {
      // _allMessagesContainedInTheStream.clear();

      debugPrint('Value from controller: $streamedMessages');

      _allMessagesContainedInTheStream.add(streamedMessages);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatMessageModel>(
      stream: _chatMessagesStream,
      builder: (context, snapshot) {
        return Expanded(
          child: ListView.builder(
            // reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            itemCount: _allMessagesContainedInTheStream.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.hasData) {
                return UserChatBubble(
                  chatMessageModelRecord:
                  _allMessagesContainedInTheStream[index],
                );
              } else {
                print(snapshot.connectionState);
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}

class UserChatBubble extends StatelessWidget {
  final ChatMessageModel chatMessageModelRecord;

  const UserChatBubble({
    Key? key,
    required this.chatMessageModelRecord,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 5,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 7 / 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
              ),
              color: primaryColor,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            child: Text(
              "${chatMessageModelRecord.message}",
              style: GoogleFonts.lato(
                fontSize: 17,
                // fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}