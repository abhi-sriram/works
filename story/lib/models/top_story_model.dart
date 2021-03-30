// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:story/models/result_model.dart';

TopStoryModel welcomeFromJson(String str) =>
    TopStoryModel.fromJson(json.decode(str));

String welcomeToJson(TopStoryModel data) => json.encode(data.toJson());

class TopStoryModel {
  TopStoryModel({
    this.status,
    this.copyright,
    this.section,
    this.lastUpdated,
    this.numResults,
    this.results,
  });

  String status;
  String copyright;
  String section;
  DateTime lastUpdated;
  int numResults;
  List<ResultModel> results;

  factory TopStoryModel.fromJson(Map<String, dynamic> json) => TopStoryModel(
        status: json["status"],
        copyright: json["copyright"],
        section: json["section"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        numResults: json["num_results"],
        results: List<ResultModel>.from(
            json["results"].map((x) => ResultModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "section": section,
        "last_updated": lastUpdated.toIso8601String(),
        "num_results": numResults,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}
