class PostModel {
  final String userName;
  final String datetime;
  final String content;
  final String imagePath;
  final String userImagePath;
  final bool isPinned;

  PostModel({
    required this.userName,
    required this.datetime,
    required this.content,
    required this.imagePath,
    required this.userImagePath,
    required this.isPinned,
  });

  static List<PostModel> createDummyPosts() {
    return [
      PostModel(
        userName: 'Firefly',
        datetime: '2025-06-01 10:00 AM',
        content:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas id lobortis turpis.',
        imagePath: 'assets/images/game1.jpg',
        userImagePath: 'assets/images/game2.jpg',
        isPinned: true,
      ),
      PostModel(
        userName: 'Stelle',
        datetime: '2025-06-01 02:30 PM',
        content:
            'Proin molestie nisl porttitor, feugiat erat pharetra, tristique ipsum. Aliquam mollis ac tortor in accumsan. Duis eu tempor neque.',
        imagePath: 'assets/images/game3.jpg',
        userImagePath: 'assets/images/game4.jpg',
        isPinned: false,
      ),
    ];
  }
}
