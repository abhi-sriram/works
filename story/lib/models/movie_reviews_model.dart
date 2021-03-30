// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MovieReviewsModel welcomeFromJson(String str) =>
    MovieReviewsModel.fromJson(json.decode(str));

String welcomeToJson(MovieReviewsModel data) => json.encode(data.toJson());

class MovieReviewsModel {
  MovieReviewsModel({
    this.status,
    this.copyright,
    this.hasMore,
    this.numResults,
    this.results,
  });

  String status;
  String copyright;
  bool hasMore;
  int numResults;
  List<Result> results;

  factory MovieReviewsModel.fromJson(Map<String, dynamic> json) =>
      MovieReviewsModel(
        status: json["status"],
        copyright: json["copyright"],
        hasMore: json["has_more"],
        numResults: json["num_results"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "copyright": copyright,
        "has_more": hasMore,
        "num_results": numResults,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.displayTitle,
    this.mpaaRating,
    this.criticsPick,
    this.byline,
    this.headline,
    this.summaryShort,
    this.publicationDate,
    this.openingDate,
    this.dateUpdated,
    this.link,
    this.multimedia,
  });

  String displayTitle;
  String mpaaRating;
  int criticsPick;
  String byline;
  String headline;
  String summaryShort;
  DateTime publicationDate;
  DateTime openingDate;
  DateTime dateUpdated;
  Link link;
  Multimedia multimedia;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        displayTitle: json["display_title"],
        mpaaRating: json["mpaa_rating"],
        criticsPick: json["critics_pick"],
        byline: json["byline"],
        headline: json["headline"],
        summaryShort: json["summary_short"],
        publicationDate: DateTime.parse(json["publication_date"]),
        openingDate: json["opening_date"] == null
            ? null
            : DateTime.parse(json["opening_date"]),
        dateUpdated: DateTime.parse(json["date_updated"]),
        link: Link.fromJson(json["link"]),
        multimedia: Multimedia.fromJson(json["multimedia"]),
      );

  Map<String, dynamic> toJson() => {
        "display_title": displayTitle,
        "mpaa_rating": mpaaRating,
        "critics_pick": criticsPick,
        "byline": byline,
        "headline": headline,
        "summary_short": summaryShort,
        "publication_date":
            "${publicationDate.year.toString().padLeft(4, '0')}-${publicationDate.month.toString().padLeft(2, '0')}-${publicationDate.day.toString().padLeft(2, '0')}",
        "opening_date": openingDate == null
            ? null
            : "${openingDate.year.toString().padLeft(4, '0')}-${openingDate.month.toString().padLeft(2, '0')}-${openingDate.day.toString().padLeft(2, '0')}",
        "date_updated": dateUpdated.toIso8601String(),
        "link": link.toJson(),
        "multimedia": multimedia.toJson(),
      };
}

class Link {
  Link({
    this.type,
    this.url,
    this.suggestedLinkText,
  });

  LinkType type;
  String url;
  String suggestedLinkText;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        type: linkTypeValues.map[json["type"]],
        url: json["url"],
        suggestedLinkText: json["suggested_link_text"],
      );

  Map<String, dynamic> toJson() => {
        "type": linkTypeValues.reverse[type],
        "url": url,
        "suggested_link_text": suggestedLinkText,
      };
}

enum LinkType { ARTICLE }

final linkTypeValues = EnumValues({"article": LinkType.ARTICLE});

class Multimedia {
  Multimedia({
    this.type,
    this.src,
    this.height,
    this.width,
  });

  MultimediaType type;
  String src;
  int height;
  int width;

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
        type: multimediaTypeValues.map[json["type"]],
        src: json["src"],
        height: json["height"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "type": multimediaTypeValues.reverse[type],
        "src": src,
        "height": height,
        "width": width,
      };
}

enum MultimediaType { MEDIUM_THREE_BY_TWO210 }

final multimediaTypeValues =
    EnumValues({"mediumThreeByTwo210": MultimediaType.MEDIUM_THREE_BY_TWO210});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
