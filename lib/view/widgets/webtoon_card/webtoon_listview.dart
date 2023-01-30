import 'package:flutter/material.dart';
import 'package:webtoon_project/model/today_model.dart';
import 'package:webtoon_project/view/widgets/webtoon_card/webtoon_card.dart';

typedef tModel = List<TodayModel>;

class WebtoonListView extends StatelessWidget {
  WebtoonListView({
    required this.snapshot,
  });

  final AsyncSnapshot<tModel> snapshot;

  @override
  Widget build(BuildContext context){
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      separatorBuilder: (a, idx) => const SizedBox(width: 40,),
      itemBuilder: (c, index) {
        var webtoon = snapshot.data![index];
        return WebtoonCard(model: webtoon);
      },
    );
  }
}