import 'package:flutter/material.dart';
import 'package:webtoon_project/model/today_model.dart';

class WebtoonCard extends StatelessWidget {
  WebtoonCard({
    required this.model,
  });

  final TodayModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            print(model.id);
          },
          child: Container(
            width: 250,
            clipBehavior: Clip.hardEdge,
            child: Image.network(model.thumbLink!),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.5),
                  ),
                ]),
          ),
        ),
        const SizedBox(height:15),
        Text(
          model.title!,
          style: TextStyle(
            fontSize: 23.0,
          ),
        ),
      ],
    );
  }
}
