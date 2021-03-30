import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      // baseColor: Colors.grey[300],
      // highlightColor: Colors.grey[100],
      baseColor: Colors.grey.shade900,
      highlightColor: Colors.grey.shade700,
      enabled: true,
      child: Container(
        height: 200,
        child: Center(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Container(
                height: 200,
                width: 200,
                margin: EdgeInsets.only(left: 6),
                color: Colors.grey,
              );
            },
            itemCount: 8,
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}
