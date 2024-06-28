import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.needSub = false,
  });
  final String url;
  final double? width;
  final double? height;
  final bool needSub;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: CachedNetworkImage(
            imageUrl: url,
            width: width,
            height: height,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        if (needSub)
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black,
                child: const Center(
                  child: Text(
                    "Only follower can see this ",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
      ],
    );
  }
}
