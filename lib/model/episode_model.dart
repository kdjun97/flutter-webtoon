class EpisodeModel {
  final String? thumb; // 썸네일 링크
  final String? id; // id
  final String? title; // 제목
  final String? rating; // 별점
  final String? date; // 날짜

  EpisodeModel ({
    required this.title,
    required this.id,
    required this.thumb,
    required this.rating,
    required this.date,
  });

  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      title : json['title'],
      id : json['id'],
      thumb : json['thumb'],
      rating : json['rating'],
      date : json['date'],
    );
  }

  @override
  String toString() {
    return '''
EpisodeModel(
  title: $title
  id: $id
  thumb: $thumb
  rating: $rating
  date: $date
''';
  }
}
