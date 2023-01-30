class DetailModel {
  final String? title; // webtoon title
  final String? genre; // 장르
  final String? about; // 소개
  final String? age; // 연령제한

  DetailModel({
    required this.title,
    required this.genre,
    required this.about,
    required this.age,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
      title: json['title'] ,
      genre: json['genre'],
      about: json['about'],
      age : json['age'],
    );
  }

  @override
  String toString() {
    return '''
DetailModel(
  title: $title
  genre: $genre
  about: $about
  age: $age
''';
  }
}