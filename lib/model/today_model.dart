List<TodayModel> todayModelListFromJson(List<dynamic> body) =>
    List<TodayModel>.from(body.map((element) => TodayModel.fromJson(element)));

class TodayModel {
  final String? title; // webtoon title
  final String? thumbLink; // 썸네일 링크
  final String? id; // unique id value

  TodayModel({
    required this.title,
    required this.thumbLink,
    required this.id,
  });

  factory TodayModel.fromJson(Map<String, dynamic> json) {
    return TodayModel(
      title: json['title'] ,
      thumbLink: json['thumb'],
      id: json['id'],
    );
  }

  @override
  String toString() {
    return '''
TodayModel(
  id: $id
  title: $title
  thumbLink: $thumbLink
''';
  }
}