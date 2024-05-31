import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sui/sui.dart';
import 'package:webio/data/constants.dart';
import 'package:webio/home_page.dart';
import 'package:webio/router/router_manager.dart';
import 'package:webio/service/api_service.dart';
import 'package:webio/step_two_web.dart';
import 'package:webio/widget/my_drop_down.dart';
import 'package:zklogin/zklogin.dart';

import 'data/storage_manager.dart';
import 'provider/zk_login_provider.dart';
import 'package:sui/sui.dart';

class ZkLoginPage extends StatefulWidget {
  const ZkLoginPage({super.key});

  @override
  State<ZkLoginPage> createState() => _ZkLoginPageState();
}

class _ZkLoginPageState extends State<ZkLoginPage> {
  final controller = ScrollController();

  final ZkLoginProvider provider = ZkLoginProvider.getInstance();

  List<String> steps = [
    'Generate Ephemeral Key Pair',
    'Fetch JWT',
    'Decode JWT',
    'Generate Salt',
    'Generate user Sui address',
    'Fetch ZK Proof',
    'Assemble zkLogin signature',
  ];

  @override
  void initState() {
    super.initState();

    _recoverCacheData();
  }

  _recoverCacheData() async {
    final url = html.window.location.href;
    print('myUrl: $url');
    print(url.startsWith(Constant.replaceUrl));
    if (url.startsWith(Constant.replaceUrl)) {
      print('_recoverCacheData');

      var keyPair = ZkLoginStorageManager.getTemporaryCacheKeyPair();
      var maxEpoch = ZkLoginStorageManager.getTemporaryMaxEpoch();
      var nonce = ZkLoginStorageManager.getTemporaryCacheNonce();
      var randomness = ZkLoginStorageManager.getTemporaryRandomness();
      var suinet = ZkLoginStorageManager.getTemporaryCacheClient();
      provider.setSuiClient(suinet);

      if (keyPair.isNotEmpty &&
          maxEpoch > 0 &&
          nonce.isNotEmpty &&
          randomness.isNotEmpty) {
        String temp = url.replaceAll(Constant.replaceUrl, '');
        provider.jwt = temp.substring(0, temp.indexOf('&'));
        provider.nonce = nonce;
        provider.maxEpoch = maxEpoch;
        provider.randomness = randomness;
        provider.account = SuiAccount.fromPrivateKey(
          keyPair,
          SignatureScheme.Ed25519,
        );
        // create user salt
        provider.salt = '178325214277756936057804824740577021427';
        // get user address
        provider.address = jwtToAddress(
          provider.jwt,
          BigInt.parse(provider.salt),
        );
        // final (salt, address) = await ApiService.getSaltAndAddress();
        // provider.address = address;
        // provider.salt = salt;
        print('provider.jwt: ${provider.jwt}');
        print('provider.address: ${provider.address}');
        print('provider.randomness: ${provider.randomness}');
        print('provider.maxEpoch: ${provider.maxEpoch}');
        provider.extendedEphemeralPublicKey = getExtendedEphemeralPublicKey(
          provider.account!.keyPair.getPublicKey(),
        );
        print('nonce: ${provider.nonce}');
        print(
            'public key: ${provider.account!.keyPair.getPublicKey().toBase64()}');
        print('publickey type: ${provider.account!.keyPair.runtimeType}');
        print(
            "provider.extendedEphemeralPublicKey: ${provider.account!.keyPair.getPublicKey().toSuiPublicKey()}");
        // Map<String, dynamic> proof = await ApiService.getProof();
        // provider.zkProof = proof;
        await provider.getZkProof(context);

        print('my proof: ${provider.zkProof}');
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            Navigator.of(context)
                .pushNamedAndRemoveUntil(Routes.mainPage, (route) => false);
          });
        });
      }
    } else {
      provider.account = SuiAccount(Ed25519Keypair());
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Consumer<ZkLoginProvider>(
      builder: (_, v, __) {
        return Scaffold(
          backgroundColor: const Color(0xff1a191b),
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.symmetric(
              vertical: width < 600 ? 20 : 40,
              horizontal: width < 600 ? 15 : 30,
            ),
            alignment: Alignment.center,
            child: SizedBox(
              width: width * 0.85,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xff665679),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            child: Image.asset(
                              'assets/images/logo2.png',
                            ),
                          ),
                          const Text(
                            'Turn ideas into command lines',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xff7c7a85),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(16),
                              bottomRight: Radius.circular(16))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          StepTwoPage(provider: provider),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
