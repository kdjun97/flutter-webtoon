import 'package:flutter/material.dart';
import 'package:webtoon_project/model/today_model.dart';
import 'package:webtoon_project/services/api_service.dart';
import 'package:webtoon_project/view/widgets/loading.dart';
import 'package:webtoon_project/view/widgets/webtoon_card/webtoon_listview.dart';

typedef tModel = List<TodayModel>;

class HomeView extends StatelessWidget {
  Future<tModel> todayModels = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('오늘의 웹툰',
          style: TextStyle(
            fontSize:22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple,
      ),
      body: FutureBuilder(
          future: todayModels,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("데이터 존재");
              // future가 완료되어 데이터가 존재하면,
              return Column(
                children: [
                  Container(
                    height:100,
                    child:Text("이미지"),
                  ),
                  Expanded(
                    child: WebtoonListView(
                      snapshot: snapshot,
                    ),
                  ),
                ],
              );
            }
            else {
              print("데이터 없음ㅠ");
              return Loading();
            }
          }),
    );
  }
}
