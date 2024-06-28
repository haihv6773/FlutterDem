import 'package:flutter/material.dart';
import 'package:flutter_dem/domain/entity/post_model.dart';

class MyPostsWidget extends StatefulWidget {
  final List<PostModel> posts;

  const MyPostsWidget(
    // Key? key,
    this.posts,
  );

  @override
  State<MyPostsWidget> createState() => _MyPostsWidgetState();
}

class _MyPostsWidgetState extends State<MyPostsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView.builder(
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.posts.length,
        itemBuilder: (context, index) {
          final post = widget.posts[0];
          return _buildPostItem(post.userName, post.userImagePath,
              post.datetime, post.imagePath, post.content, post.isPinned);
        },
      ),
    );
  }

  Widget _buildPostItem(String userName, String userImagePath, String postDate,
      String postImagePath, String postContent, bool isPinned) {
    return Container(
      color: Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Visibility(
              visible: isPinned,
              child: const Row(
                children: [
                  Text(
                    'Pinned',
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  SizedBox(width: 3),
                  Icon(Icons.push_pin, color: Colors.black54, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 5),
            _buildPostInfoUser(userName, userImagePath, postDate),
            const SizedBox(height: 5),
            _buildPostBody(postContent, postImagePath),
          ],
        ),
      ),
    );
  }

  Widget _buildPostInfoUser(
      String userName, String userImagePath, String postDate) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image(
            image: AssetImage(userImagePath),
            width: 50,
            height: 50,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 3),
                const Icon(Icons.verified, color: Color(0xFF3400B1), size: 14),
              ],
            ),
            Row(
              children: [
                Text(
                  '$postDate · ',
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
                const Icon(
                  Icons.people_outline,
                  color: Colors.black54,
                  size: 18,
                ),
              ],
            ),
          ],
        ),
        const Expanded(child: SizedBox()),
        const Icon(Icons.more_vert, color: Colors.black, size: 22),
      ],
    );
  }

  Widget _buildPostBody(String content, String imagePath) {
    return Row(
      children: [
        const SizedBox(width: 58),
        Expanded(
          child: Column(
            children: [
              Text(
                content,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFCFCCCC)!),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    image: AssetImage(imagePath),
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.star_outline, color: Colors.black, size: 26),
                  SizedBox(width: 10),
                  Icon(Icons.chat_bubble_outline,
                      color: Colors.black, size: 22),
                  SizedBox(width: 10),
                  Icon(Icons.bookmark_outline, color: Colors.black, size: 24),
                  SizedBox(width: 10),
                  Icon(Icons.share_outlined, color: Colors.black, size: 24),
                  SizedBox(width: 10),
                  Icon(Icons.card_giftcard_outlined,
                      color: Colors.black, size: 24),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
