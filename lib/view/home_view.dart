import 'package:flutter/material.dart';
import 'package:webtoon_project/model/today_model.dart';
import 'package:webtoon_project/services/api_service.dart';
import 'package:webtoon_project/view/widgets/loading.dart';
import 'package:webtoon_project/view/widgets/my_app_bar.dart';

class HomeView extends StatelessWidget {
  Future<List<TodayModel>> todayModels = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(appBar:AppBar()),
      body: FutureBuilder(
        future: todayModels,
        builder: (context, snapshot) {
          if(snapshot.hasData) { // future가 완료되어 데이터가 존재하면,
            return Text("${snapshot.data?[0]}");
          }
          return Loading();
        }
      ),
    );
  }
}
