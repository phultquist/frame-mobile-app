import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

final WebSocketChannel channel =
    IOWebSocketChannel.connect('ws://192.168.68.102:8000');
Map<String, dynamic> data;

void updateSettings(String field, String value) {
  data[field] = value;
  channel.sink.add(jsonEncode(data));
}
