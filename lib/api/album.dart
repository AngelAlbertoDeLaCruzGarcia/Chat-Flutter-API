import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_bim/data/album.dart';

Future<List<Album>> fetchAlbum() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    List<Album> album = body
        .map(
          (dynamic item) => Album.fromJson(item),
        )
        .toList();
    print(body);
    return album;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
