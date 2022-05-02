import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_bim/data/message.dart';
import 'package:api_bim/utils/constants.dart';

class MessageApi {
  var url;
  var response;
  List<dynamic> body = [];
  List<Message> msgs = [];
  Future<List<Message>> getMessages(int chat) async {
    url = Uri.parse('${API_URL}/msgs/chat?id=${chat}');
    response = await http.get(url);
    if (response.statusCode == 200) {
      body = jsonDecode(response.body);
      msgs = body
          .map(
            (dynamic item) => Message.fromJson(item),
          )
          .toList();
      return msgs;
    } else if (response.statusCode == 404) {
      throw Exception('Sin mensajes');
    } else {
      throw Exception('Erorr en la petición');
    }
  }

  Future<bool> addMessage(Map msg) async {
    url = Uri.parse('${API_URL}/msgs/create');
    response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(msg));
    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      return false;
    } else if (response.statusCode == 404) {
      return false;
    } else {
      return false;
    }
  }

  Future<bool> deleteMessage(int id) async {
    url = Uri.parse('${API_URL}/msgs/logicaldelete/${id}');
    response = await http.put(url);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
