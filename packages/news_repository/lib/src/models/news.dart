class News {
  int id;
  String title;
  String text;
  DateTime dateTime;
  String? previewPath;
  String? mainImagePath;
  List<String>? additionalImagesPaths;
  
  News({
    required this.id,
    required this.title,
    required this.text,
    required this.dateTime,
    this.previewPath,
    this.mainImagePath,
    this.additionalImagesPaths,
    
  });

  

}
