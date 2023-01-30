import 'package:flutter/material.dart';
import 'package:webtoon_project/model/detail_model.dart';
import 'package:webtoon_project/model/today_model.dart';
import 'package:webtoon_project/services/api_service.dart';
import 'package:webtoon_project/view/widgets/loading.dart';
import 'package:webtoon_project/view/widgets/my_app_bar.dart';
import 'package:webtoon_project/view/widgets/webtoon_card/webtoon_card.dart';

class DetailView extends StatefulWidget {
  DetailView({required this.todayModel});

  TodayModel todayModel;

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  late Future<DetailModel> detailModel;

  @override
  void initState() {
    super.initState();
    detailModel = ApiService.getDetailToon(widget.todayModel.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appBar: AppBar(), title: widget.todayModel.title!),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: WebtoonCard(model: widget.todayModel,),
              ),
            ],
          ),
          const SizedBox(height:20.0,),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Text(
'''[장르]:${snapshot.data!.genre!}
[연령]:${snapshot.data!.age}
${snapshot.data!.about!}''',
                    maxLines: 4,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
              return Loading();
            },
            future: detailModel,
          ),
          // FutureBuilder(),
        ],
      ),
    );
  }
}