import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:webtoon_project/model/detail_model.dart';
import 'package:webtoon_project/model/episode_model.dart';
import 'package:webtoon_project/model/today_model.dart';

class ApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<TodayModel>> getTodaysToons() async {
    List<TodayModel> webtoonModelList = [];
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      webtoonModelList = todayModelListFromJson(result);
      return webtoonModelList;
    }
    throw Error();
  }

  static Future<DetailModel> getDetailToon(String id) async {
    final url = Uri.parse('$baseUrl/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return DetailModel.fromJson(jsonDecode(response.body));
    }
    throw Error();
  }

  static Future<List<EpisodeModel>> getEpisodeToons(String id) async {
    List<EpisodeModel> episodeModels = [];
    final url = Uri.parse('$baseUrl/$id/episodes');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      episodeModels = episodeModelListFromJson(result);
      return episodeModels;
    }
    throw Error();
  }
}