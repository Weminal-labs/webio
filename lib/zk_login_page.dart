import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sui/sui.dart';
import 'package:webio/data/constants.dart';
import 'package:webio/home_page.dart';
import 'package:webio/step_two_web.dart';
import 'package:zklogin/zklogin.dart';

import 'data/storage_manager.dart';
import 'provider/zk_login_provider.dart';

class ZkLoginPage extends StatefulWidget {
  const ZkLoginPage({super.key});

  @override
  State<ZkLoginPage> createState() => _ZkLoginPageState();
}

class _ZkLoginPageState extends State<ZkLoginPage> {
  final controller = ScrollController();

  final ZkLoginProvider provider = ZkLoginProvider();

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
    if (url.startsWith(Constant.replaceUrl)) {
      print('_recoverCacheData');

      var keyPair = ZkLoginStorageManager.getTemporaryCacheKeyPair();
      var maxEpoch = ZkLoginStorageManager.getTemporaryMaxEpoch();
      var nonce = ZkLoginStorageManager.getTemporaryCacheNonce();
      var randomness = ZkLoginStorageManager.getTemporaryRandomness();

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
        await provider.getBalance();
        print('provider.jwt: ${provider.jwt}');
        print('provider.address: ${provider.address}');
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          provider: provider,
                        )),
                (route) => false);
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
    return ChangeNotifierProvider(
      create: (_) => provider,
      child: Consumer<ZkLoginProvider>(
        builder: (_, v, __) {
          return Scaffold(
            appBar: AppBar(title: const Text('Sui zkLogin Dart Demo')),
            body: SingleChildScrollView(
              controller: controller,
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: width < 600 ? 20 : 40,
                  horizontal: width < 600 ? 15 : 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StepTwoPage(provider: provider),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
