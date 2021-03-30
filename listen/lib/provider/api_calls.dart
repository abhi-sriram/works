import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class ApiCalls {
  String url = 'https://deezerdevs-deezer.p.rapidapi.com/track/1270420082';

  Future<void> getAllPosts() async {
    final response = await http.get(Uri.parse(url), headers: {
      "x-rapidapi-key": "9a06fc1ab7msh120dfc13eec3a31p105e23jsn57ece39ed94c",
      "x-rapidapi-host": "deezerdevs-deezer.p.rapidapi.com",
    });
    print(response.body);
  }
}
// .setHeader("x-rapidapi-key", "9a06fc1ab7msh120dfc13eec3a31p105e23jsn57ece39ed94c")
// 	.setHeader("x-rapidapi-host", "deezerdevs-deezer.p.rapidapi.com")