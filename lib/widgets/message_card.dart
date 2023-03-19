import 'package:flutter/material.dart';

import '../model/message_model.dart';

class MessageCardW extends StatelessWidget {
  final MessageDataModel message;
  const MessageCardW({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }

// sender or another user messages
  Widget _blueMessages() {
    return Container();
  }

  // our or user messages
  Widget _greenMessages() {
    return Container();
  }
}
