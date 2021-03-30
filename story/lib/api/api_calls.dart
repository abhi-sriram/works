import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:story/models/result_model.dart';
import 'package:story/models/top_story_model.dart';

class ApiCalls with ChangeNotifier {
  String apiKey = "acTlrjz7T2lQgq8IM9sLWGWuEpUcXdXT";
  List<ResultModel> _stories = [];

  List<ResultModel> getStories() {
    return _stories;
  }

  // mostPopularResults() async {
  //   // results
  //   // num_results
  //   // most popular completed
  //   final mostPopular =
  //       "https://api.nytimes.com/svc/mostpopular/v2/shared/1/facebook.json?api-key=$apiKey";

  //   var response = await http.get(
  //     Uri.parse(mostPopular),
  //   );
  //   final body = convert.jsonDecode(response.body);
  //   final len = body['num_results'];
  //   for (var i = 0; i < len; i++) {
  //     MostPopularModel model = MostPopularModel.fromJson((body['results'][i]));
  //     // print(model.url);
  //     print(model.source);
  //     // print(model.media[0].mediaMetadata[0].url);
  //     for (var item in model.media) {
  //       for (var item1 in item.mediaMetadata) {
  //         print(item1.url);
  //       }
  //     }
  //   }
  //   print(len);
  // }

  // movieReviewsResults() async {
  //   final reviewsApi =
  //       "https://api.nytimes.com/svc/movies/v2/reviews/picks.json?api-key=$apiKey";
  //   var response = await http.get(
  //     Uri.parse(reviewsApi),
  //   );
  //   final body = convert.jsonDecode(response.body);
  //   MovieReviewsModel model = MovieReviewsModel.fromJson(body);
  //   for (var item in model.results) {
  //     print(item.link.url);
  //   }
  // }

  topStories(List<String> tags) async {
    if (_stories.length == 0) {
      for (var tag in tags) {
        final topStoriesApi =
            'https://api.nytimes.com/svc/topstories/v2/$tag.json?api-key=$apiKey';
        var response = await http.get(
          Uri.parse(topStoriesApi),
        );
        final body = convert.jsonDecode(response.body);
        TopStoryModel model = TopStoryModel.fromJson(body);
        for (var item in model.results) {
          _stories.add(item);
        }
      }
      _stories.shuffle();
      notifyListeners();
    } else {
      notifyListeners();
    }
  }
}
