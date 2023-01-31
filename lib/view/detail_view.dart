import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon_project/model/detail_model.dart';
import 'package:webtoon_project/model/episode_model.dart';
import 'package:webtoon_project/model/today_model.dart';
import 'package:webtoon_project/services/api_service.dart';
import 'package:webtoon_project/view/widgets/loading.dart';
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
  late SharedPreferences pref;
  bool isLiked = false;

  onHeartTap() async {
    final likedToons = pref.getStringList('likedToons');
    if (likedToons != null) {
      isLiked ? likedToons.remove(widget.todayModel.id)
        : likedToons.add(widget.todayModel.id!);
      await pref.setStringList('likedToons', likedToons);
      setState(() { isLiked = !isLiked;});
    }
  }

  Future initPrefs() async {
    pref = await SharedPreferences.getInstance();
    final likedToons = pref.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.todayModel.id) == true) {
        isLiked=true;
        setState(() {});
      }
    } else {
      await pref.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    detailModel = ApiService.getDetailToon(widget.todayModel.id!);
    episodeModelList = ApiService.getEpisodeToons(widget.todayModel.id!);
    initPrefs();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todayModel.title!,
        style: const TextStyle(
          fontSize:22.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 2,
      backgroundColor: Colors.white,
      foregroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: isLiked ? const Icon(Icons.favorite) : const Icon(Icons.favorite_outline),
            onPressed: () => onHeartTap()
          )
        ],
    ),
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
                            onTap: () async {
                              final url = "${ApiService.launchUrl}titleId=${widget.todayModel.id}&no=${episode.id}";
                              print("${episode.title} clicked!");
                              await launchUrlString(url);
                            },
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