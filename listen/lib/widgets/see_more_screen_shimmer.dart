import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SeeMoreScreenShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade700,
      enabled: true,
      child: ListView.separated(
        itemCount: 15,
        itemBuilder: (ctx, index) {
          return Container(
            height: 100,
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Icon(
                  Icons.queue_music_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 30,
                )
              ],
            ),
          );
        },
        separatorBuilder: (ctx, index) {
          return Container(
            height: 3,
            color: Colors.white,
          );
        },
      ),
    );
  }
}
