class MostPopularModel {
  String uri;
  String url;
  int id;
  int assetId;
  String source;
  DateTime publishedDate;
  DateTime updated;
  String section;
  String subsection;
  String nytdsection;
  String adxKeywords;
  dynamic column;
  String byline;
  String type;
  String title;
  String welcomeAbstract;
  List<String> desFacet;
  List<dynamic> orgFacet;
  List<dynamic> perFacet;
  List<String> geoFacet;
  List<Media> media;
  int etaId;
  MostPopularModel({
    this.uri,
    this.url,
    this.id,
    this.assetId,
    this.source,
    this.publishedDate,
    this.updated,
    this.section,
    this.subsection,
    this.nytdsection,
    this.adxKeywords,
    this.column,
    this.byline,
    this.type,
    this.title,
    this.welcomeAbstract,
    this.desFacet,
    this.orgFacet,
    this.perFacet,
    this.geoFacet,
    this.media,
    this.etaId,
  });

  factory MostPopularModel.fromJson(Map<String, dynamic> json) {
    // print(json['media'][0]);
    return MostPopularModel(
      uri: json["uri"],
      url: json["url"],
      id: json["id"],
      assetId: json["asset_id"],
      source: json["source"],
      publishedDate: DateTime.parse(json["published_date"]),
      updated: DateTime.parse(json["updated"]),
      section: json["section"],
      subsection: json["subsection"],
      nytdsection: json["nytdsection"],
      adxKeywords: json["adx_keywords"],
      column: json["column"],
      byline: json["byline"],
      type: json["type"],
      title: json["title"],
      welcomeAbstract: json["abstract"],
      desFacet: List<String>.from(json["des_facet"].map((x) => x)),
      orgFacet: List<dynamic>.from(json["org_facet"].map((x) => x)),
      perFacet: List<dynamic>.from(json["per_facet"].map((x) => x)),
      geoFacet: List<String>.from(json["geo_facet"].map((x) => x)),
      media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      // media: Media.fromJson(json['media'][0]),

      etaId: json["eta_id"],
    );
  }
}

class Media {
  Media({
    this.type,
    this.subtype,
    this.caption,
    this.copyright,
    this.approvedForSyndication,
    this.mediaMetadata,
  });

  String type;
  String subtype;
  String caption;
  String copyright;
  int approvedForSyndication;
  List<MediaMetadatum> mediaMetadata;

  factory Media.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Media(
      type: json['type'],
      subtype: json["subtype"],
      caption: json["caption"],
      copyright: json["copyright"],
      approvedForSyndication: json["approved_for_syndication"],
      // mediaMetadata: List<MediaMetadatum>.from(
      //     json["media-metadata"].map((x) => MediaMetadatum.fromJson(x))),
      mediaMetadata: List.generate(json['media-metadata'].length,
          (index) => MediaMetadatum.fromJson(json['media-metadata'][index])),
    );
  }
}

class MediaMetadatum {
  MediaMetadatum({
    this.url,
    this.format,
    this.height,
    this.width,
  });

  String url;
  String format;
  int height;
  int width;

  factory MediaMetadatum.fromJson(Map<String, dynamic> json) => MediaMetadatum(
        url: json["url"],
        format: json["format"],
        height: json["height"],
        width: json["width"],
      );
}
