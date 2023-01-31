import 'package:flutter/material.dart';
import 'package:webtoon_project/model/detail_model.dart';
import 'package:webtoon_project/model/episode_model.dart';
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
  late Future<List<EpisodeModel>> episodeModelList;

  @override
  void initState() {
    super.initState();
    detailModel = ApiService.getDetailToon(widget.todayModel.id!);
    episodeModelList = ApiService.getEpisodeToons(widget.todayModel.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(appBar: AppBar(), title: widget.todayModel.title!),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,40,8.0,40),
        child: ListView(
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
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
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
            FutureBuilder(
              future: episodeModelList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      for (var episode in snapshot.data!)
                        Container(
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                          child: GestureDetector(
                            onTap: (){ print("${episode.title} clicked!"); },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width*0.7,
                                  child: Text(episode.title!,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 17,
                                  )),
                                ),
                                const Icon(Icons.chevron_right)
                              ],
                            ),
                          )
                        )
                    ],
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}