import 'package:flutter/material.dart';
import 'package:flutter_dem/detail/detail_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: AppBarHeaderDelegate(headerTitle: widget.title),
            pinned: true,
          ),
          _buildListBanner(),
          const SliverPersistentHeader(
            delegate: HomeHeaderDelegate(
                height: 40,
                headerTitle: 'Games on Tevi',
                showRightButton: true),
          ),
          _buildSliverGameList(),
          const SliverPadding(padding: EdgeInsets.only(bottom: 10)),
          const SliverPersistentHeader(
            delegate: HomeHeaderDelegate(
                height: 40,
                headerTitle: 'Explore Your Creators',
                showRightButton: false),
          ),
          _buildSliverUsersGrid(),
        ],
      ),
    );
  }

  Widget _buildSliverGameList() {
    return SliverToBoxAdapter(
      child: Container(
        height: 120,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          children: [
            _buildGameItem('assets/images/game1.jpg', 'Lucky Fruits'),
            const SizedBox(width: 10),
            _buildGameItem('assets/images/game2.jpg', 'Fruits Merge'),
            const SizedBox(width: 10),
            _buildGameItem('assets/images/game3.jpg', 'Candy Crush'),
            const SizedBox(width: 10),
            _buildGameItem(
                'assets/images/game4.jpg', 'Business Tour Business Tour'),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverUsersGrid() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      delegate: SliverChildListDelegate(
        [
          _buildGridItem(
              context, 'assets/images/game1.jpg', 'MaiQuinn', '@MAIQUINNVNLE'),
          _buildGridItem(context, 'assets/images/game2.jpg', 'Host Nguyen',
              '@hostnguyenkhang'),
          _buildGridItem(
              context, 'assets/images/game3.jpg', 'Thieu Rino', '@ThieuRino'),
          _buildGridItem(
              context, 'assets/images/game4.jpg', 'Firefly', '@firefly'),
          _buildGridItem(
              context, 'assets/images/game5.jpg', 'Stelle', '@stelle'),
          _buildGridItem(context, 'assets/images/game1.jpg',
              'Aventurine Tempozjxhc', '@aventurine'),
        ],
      ),
    );
  }

  Widget _buildListBanner() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            margin: const EdgeInsets.all(10.0),
            child: const Image(
              image: AssetImage('assets/images/banner.png'),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGameItem(String imagePath, String name) {
    return Container(
      color: Colors.white,
      height: 120.0,
      width: 100.0,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image(
              image: AssetImage(imagePath),
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
      BuildContext context, String imagePath, String name, String userId) {
    return InkWell(
      onTap: () {
        openDetailScreen(context);
      },
      child: Container(
        color: Colors.white,
        height: 140.0,
        width: 80.0,
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image(
                  image: AssetImage(imagePath),
                  width: 80,
                  height: 80,
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 90,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        name,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const SizedBox(
                      width: 10,
                      child: Icon(
                        Icons.verified,
                        color: Color(0xFF3400B1),
                        size: 14,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                userId,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final String headerTitle;
  final String? rightButtonTitle;
  final bool showRightButton;

  const HomeHeaderDelegate({
    required this.height,
    required this.headerTitle,
    this.rightButtonTitle,
    required this.showRightButton,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: height,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              headerTitle,
              style: const TextStyle(
                color: Color(0xFF3400B1),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Visibility(
            visible: showRightButton,
            child: InkWell(
              // GestureDetector
              onTap: () {
                print('See all action');
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Text(
                  'See all',
                  style: TextStyle(
                    color: Color(0xFF3400B1),
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class AppBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String headerTitle;

  const AppBarHeaderDelegate({
    required this.headerTitle,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                  width: 30,
                  child: IconButton(
                    icon: const Icon(Icons.menu),
                    color: Colors.grey,
                    onPressed: _onMenuClick,
                  ),
                ),
              ),
              _buildStarsWidget(10),
            ]),
            Text(
              headerTitle,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: const Icon(Icons.notifications),
                      color: Colors.grey,
                      onPressed: _onNotifications,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: const Icon(Icons.message),
                      color: Colors.grey,
                      onPressed: _onChatMessage,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: SizedBox(
                    width: 30,
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.grey,
                      onPressed: _onHomeSearch,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

  void _onHomeSearch() {
    print('Home Search Action');
  }

  void _onChatMessage() {
    print('Message Action');
  }

  void _onNotifications() {
    print('Notification Action');
  }

  void _onMenuClick() {
    print('Menu Action');
  }
}

Widget _buildStarsWidget(int stars) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.centerRight,
    children: [
      Container(
        height: 30,
        decoration: BoxDecoration(
          color: const Color(0xFFE9E9E9),
          borderRadius: BorderRadius.circular(15), // Add border radius here
          border:
              Border.all(color: Colors.transparent), // Add border color here
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              const Icon(
                Icons.stars,
                color: Color(0xFF764CDA),
                size: 20,
              ),
              Text(
                '$stars',
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
      const Positioned(
        right: -8,
        child: Icon(
          Icons.add_circle_rounded,
          color: Colors.grey,
          size: 20, // Custom width and height of the icon
        ),
      ),
    ],
  );
}

Future openDetailScreen(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const DetailScreen(),
    ),
  );
}
