class News {
  int? id;
  String? title;
  String? text;
  DateTime? dateTime;
  String? previewPath;
  String? mainImagePath;
  List<dynamic>? additionalImagesPaths;
  String? language;

  News({
    this.id,
    this.title,
    this.text,
    this.dateTime,
    this.previewPath,
    this.mainImagePath,
    this.additionalImagesPaths,
    this.language,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        id: json['Id'] as int?,
        title: json['Title'] as String?,
        text: json['Text'] as String?,
        dateTime: json['DateTime'] == null
            ? null
            : DateTime.parse(json['DateTime'] as String),
        previewPath: json['PreviewPath'] as String?,
        mainImagePath: json['MainImagePath'] as String?,
        additionalImagesPaths: json['AdditionalImagesPaths'] as List<dynamic>?,
        language: json['Language'] as String?,
      );

}
