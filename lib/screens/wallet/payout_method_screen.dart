import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PayoutMethodScreen extends StatefulWidget {
  const PayoutMethodScreen({super.key});

  @override
  State<PayoutMethodScreen> createState() => _PayoutMethodScreenState();
}

enum PayoutMethod { bankTransfer, payoneer, usdt, vaiWallet }

class _PayoutMethodScreenState extends State<PayoutMethodScreen> {
  PayoutMethod? selectedMethod;
  String selectedCountry = 'Vietnam';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          'Setup Payouts',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: _buildLayout(),
                  ),
                ),
              ],
            ),
          ),
          _buildSubmitBottomWidget(),
        ],
      ),
    );
  }

  void _onSubmitPayoutMethod() {
    print('Submit payout method action');
  }

  Widget _buildSubmitBottomWidget() {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: Offset.zero,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: RichText(
              text: const TextSpan(
                text: 'By tapping "Continue", you agree to our ',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
                children: [
                  TextSpan(
                    text: 'Terms and Service',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
              width: double.infinity,
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  disabledForegroundColor: Colors.grey,
                  disabledBackgroundColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed:
                    selectedMethod == null ? null : _onSubmitPayoutMethod,
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Let\'s add a payout method',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'To start, let us know where you\'d like us to send your money',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          'Billing country/region',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: const TextSpan(
            text: 'This is where you opened your financial account. ',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: 'More info',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        _buildCountryDropdown(),
        const SizedBox(height: 15),
        const Text(
          'How would you like to get paid?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: const TextSpan(
            text:
                'Available Payout Methods. Payout review could result in holds and delays. ',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
            children: [
              TextSpan(
                text: 'Learn more',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        PayoutMethodsWidget(
          onPayoutMethodChanged: (selected) {
            selectedMethod = selected;
            print('Selected payout method: $selectedMethod');
            setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildCountryDropdown() {
    return DropdownButtonFormField(
      value: selectedCountry,
      style: const TextStyle(
        color: Colors.deepPurple,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      icon: const Icon(
        Icons.arrow_circle_right,
        color: Colors.grey,
        size: 30,
      ),
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC1C1C1)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC1C1C1)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      items: const <DropdownMenuItem>[
        DropdownMenuItem(
          value: 'Vietnam',
          child: Text('Vietnam'),
        ),
        DropdownMenuItem(
          value: 'Chinese',
          child: Text('Chinese'),
        ),
        DropdownMenuItem(
          value: 'France',
          child: Text('France'),
        ),
      ],
      onChanged: (value) {
        selectedCountry = value.toString();
        print('Selected country: $value');
      },
    );
  }
}

class PayoutMethodsWidget extends StatefulWidget {
  const PayoutMethodsWidget({super.key, required this.onPayoutMethodChanged});

  final Function(PayoutMethod) onPayoutMethodChanged;

  @override
  State<PayoutMethodsWidget> createState() => PayoutMethodsWidgetState();
}

class PayoutMethodsWidgetState extends State<PayoutMethodsWidget> {
  PayoutMethod? _method;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPayoutMethodItem(
              context,
              'assets/images/method_bank.png',
              'Bank Transfer 24/7 (VND)',
              '4.5%',
              '2 business days',
              PayoutMethod.bankTransfer,
              _method,
              (selected) {
                setState(() {
                  _method = selected;
                  widget.onPayoutMethodChanged(selected);
                });
              },
            ),
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPayoutMethodItem(
              context,
              'assets/images/method_payoneer.png',
              'Payoneer (USD)',
              '1 USD',
              '3 business days',
              PayoutMethod.payoneer,
              _method,
              (selected) {
                setState(() {
                  _method = selected;
                  widget.onPayoutMethodChanged(selected);
                });
              },
            ),
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPayoutMethodItem(
              context,
              'assets/images/method_usdt.png',
              'USDT (USDT)',
              '1 USD',
              '1 business day',
              PayoutMethod.usdt,
              _method,
              (selected) {
                setState(() {
                  _method = selected;
                  widget.onPayoutMethodChanged(selected);
                });
              },
            ),
          ),
          _buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildPayoutMethodItem(
              context,
              'assets/images/method_vai_wallet.png',
              'VAI Wallet (USDT)',
              '0 USD',
              '1 business day',
              PayoutMethod.vaiWallet,
              _method,
              (selected) {
                setState(() {
                  _method = selected;
                  widget.onPayoutMethodChanged(selected);
                });
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

  Widget _buildPayoutMethodItem(
    BuildContext context,
    String iconPath,
    String itemName,
    String transactionFee,
    String processingTime,
    PayoutMethod method,
    PayoutMethod? selectedMethod,
    Function(PayoutMethod) onChanged,
  ) {
    return InkWell(
      onTap: () {
        onChanged(method);
      },
      child: SizedBox(
        height: 100,
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 32,
              height: 32,
            ),
            const SizedBox(width: 16),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  transactionFee,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  processingTime,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Radio<PayoutMethod>(
              value: method,
              groupValue: selectedMethod,
              onChanged: (PayoutMethod? value) {
                onChanged(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
