import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_dem/domain/entity/post_model.dart";
import "package:flutter_dem/dummy.dart";
import "package:flutter_dem/screens/detail/my_post_widget.dart";
import "package:flutter_dem/screens/home/home_screen.dart";
import "package:flutter_dem/screens/wallet/wallet_screen.dart";
import "package:flutter_dem/screens/widget/app_image.dart";

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  late List<PostModel> _posts;

  final String _userName = 'Emily';
  final String _userImagePath = kPeopleImages[2];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _posts = PostModel.createDummyPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          _buildTopContainer(_userImagePath),
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              bottom: TabBar(
                controller: _tabController,
                isScrollable: false,
                dividerColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorWeight: 3,
                tabs: const <Widget>[
                  Tab(text: 'Posts'),
                  Tab(text: 'About'),
                ],
              ),
              floating: true,
              backgroundColor: Colors.white,
              pinned: true,
              snap: false,
              expandedHeight: 40,
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _wrapWithBuilder(
              "myPost",
              SliverList.builder(
                itemBuilder: (_, index) => _buildPostItem(
                  _userName,
                  _userImagePath,
                  "Today",
                  kPostImages[index % kPostImages.length],
                  "Haha",
                  index == 0,
                  index % 3 == 0,
                ),
              ),
            ),
            _wrapWithBuilder(
              "About",
              const SliverToBoxAdapter(
                child: Center(
                  child: Text('Placeholder of the About tab'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wrapWithBuilder(String keyName, Widget child) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Builder(builder: (context) {
        return CustomScrollView(
          key: PageStorageKey<String>(keyName),
          slivers: [
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(6),
              sliver: child,
            ),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
    // return Scaffold(
    //   backgroundColor: const Color(0xFFDADADA),
    //   body: Stack(
    //     children: [
    //       CustomScrollView(
    //         slivers: <Widget>[
    //           _buildTopContainer(_userImagePath),

    //           SliverToBoxAdapter(
    //             child: Container(
    //               color: Colors.white,
    //               height: 100,
    //               child: Column(
    //                 children: [
    //                   TabBar(
    //                     controller: _tabController,
    //                     isScrollable: false,
    //                     dividerColor: Colors.black,
    //                     labelColor: Colors.black,
    //                     unselectedLabelColor: Colors.grey,
    //                     indicatorWeight: 3,
    //                     tabs: const <Widget>[
    //                       Tab(text: 'Posts'),
    //                       Tab(text: 'About'),
    //                     ],
    //                   ),
    //                   const SizedBox(height: 20),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           SliverFillRemaining(
    //             child: TabBarView(
    //               controller: _tabController,
    //               children: <Widget>[
    //                 MyPostsWidget(
    //                   posts: _posts,
    //                 ),
    //                 const Center(
    //                   child: Text('Placeholder of the About tab'),
    //                 ),
    //               ],
    //             ),
    //           )
    //           // _buildBottomGradientFooter(),
    //         ],
    //       ),
    //       _buildTopBar(context, 100),
    //     ],
    //   ),
    // );
  }

  Widget _buildTopContainer(String imagePath) {
    return SliverToBoxAdapter(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 60),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFDADADA), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            color: Colors.grey,
            borderRadius: BorderRadius.zero,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              // height: 250,
              color: Colors.transparent,
              child: _buildUserInfo(imagePath),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(String imagePath) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 6,
                offset: Offset.zero,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: AppImage(
              url: kPeopleImages[0],
              width: 100,
              height: 100,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildUserName(_userName, true),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMemberCount('100', 'Followers'),
              Container(width: 1, height: 20, color: Colors.grey[350]),
              _buildMemberCount('22', 'Members'),
              Container(width: 1, height: 20, color: Colors.grey[350]),
              _buildMemberCount('33', 'Posts'),
              Container(width: 1, height: 20, color: Colors.grey[350]),
              _buildMemberCount('\$125', 'Income+'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildUserName(String userName, bool isVeriried) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _userName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 5),
        Visibility(
          visible: isVeriried,
          child: const SizedBox(
            width: 20,
            child: Icon(Icons.verified, color: Color(0xFF3400B1), size: 20),
          ),
        )
      ],
    );
  }

  Widget _buildMemberCount(String countText, String description) {
    return Column(
      children: [
        Text(
          countText,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                print('Member button clicked');
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF3400B1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Become A Member',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              print('Donate button clicked');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFC1C1C1)),
              ),
              width: 80,
              height: 40,
              child: const Center(
                child: Text(
                  'Donate',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          InkWell(
            onTap: () {
              print('Message button clicked');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFC1C1C1)),
              ),
              width: 50,
              height: 40,
              child: const Center(
                child: Icon(
                  Icons.send_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, double height) {
    return Container(
      height: height,
      color: Colors.transparent,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 5),
              child: SizedBox(
                width: 30,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            buildStarsCount(10, backgroundColor: Colors.grey[200]!),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: SizedBox(
                width: 30,
                child: IconButton(
                  icon: const Icon(Icons.more_rounded),
                  color: Colors.grey,
                  onPressed: () {
                    print('more button clicked');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomGradientFooter() {
    return const DecoratedSliver(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFFDADADA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      sliver: SliverToBoxAdapter(
        child: Expanded(
          child: SizedBox(
            height: 100,
          ),
        ),
      ),
    );
  }

  Widget _buildPostItem(
    String userName,
    String userImagePath,
    String postDate,
    String postImagePath,
    String postContent,
    bool isPinned,
    bool onlyForFollower,
  ) {
    return Padding(
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
          _buildPostBody(postContent, postImagePath, onlyForFollower),
        ],
      ),
    );
  }

  Widget _buildPostInfoUser(
      String userName, String userImagePath, String postDate) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: AppImage(
              url: userImagePath,
              width: 50,
              height: 50,
            )),
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

  Widget _buildPostBody(
    String content,
    String imagePath,
    bool onlyForFollower,
  ) {
    return Row(
      children: [
        const SizedBox(width: 58),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (onlyForFollower) {
                    openWalletScreen(context);
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: AppImage(
                    url: imagePath,
                    height: 150,
                    needSub: onlyForFollower,
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

Future openWalletScreen(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const WalletScreen(),
    ),
  );
}
