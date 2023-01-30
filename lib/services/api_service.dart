import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:webtoon_project/model/today_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<TodayModel>> getTodaysToons() async {
    print("api 서비스 안");
    List<TodayModel> webtoonModelList = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('status 200');
      List<dynamic> webtoons = jsonDecode(response.body);
      webtoons.forEach((element) {
        webtoonModelList.add(TodayModel.fromJson(element));
      });
      return webtoonModelList;
    }
    throw Error();
  }
}