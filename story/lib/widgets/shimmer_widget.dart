import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey,
              padding: EdgeInsets.all(2),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: media.height * 0.2,
            width: double.infinity,
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
