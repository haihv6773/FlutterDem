import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dem/screens/wallet/payout_method_screen.dart';
import 'package:flutter_dem/widget/custom_tabbar.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text('My Wallet',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomTabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'STAR'),
            Tab(text: 'USD'),
          ],
          tabbarViews: const [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Star tab content goes here'),
            ),
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: BuildTotalBalance(),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BuildTotalBalance extends StatelessWidget {
  const BuildTotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFC1C1C1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TOTAL BALANCE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '\$0.00',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Image(
                      image: AssetImage('assets/images/question.png'),
                      color: Colors.white,
                      width: 16,
                      height: 16,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildItem(
              context,
              'assets/images/payout_request.png',
              'Payout Request',
              () {},
            ),
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildItem(
              context,
              'assets/images/payout_method.png',
              'Payout Method',
              () {
                openPayoutMethodScreen(context);
              },
            ),
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildItem(
              context,
              'assets/images/payout_tracking.png',
              'Payout Tracking',
              () {
                print('Payout Request');
              },
            ),
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildItem(
              context,
              'assets/images/transaction_history.png',
              'Transaction History',
              () {
                print('Transaction History');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
        height: 1, color: Color(0xFFC1C1C1), indent: 10, endIndent: 10);
  }

  Widget _buildItem(
      BuildContext context, String iconPath, String itemName, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height: 80,
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 16),
            Text(
              itemName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Expanded(child: SizedBox()),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

Future openPayoutMethodScreen(BuildContext context) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => const PayoutMethodScreen(),
    ),
  );
}
