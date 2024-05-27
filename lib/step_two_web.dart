import "dart:html" as html;

import 'package:flutter/material.dart';
import 'package:flutter_macos_webview/flutter_macos_webview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' hide generateNonce;
import 'package:sui/sui.dart';
import 'package:zklogin/zklogin.dart';

import 'common/theme.dart';
import 'data/constants.dart';
import 'provider/zk_login_provider.dart';

class StepTwoPage extends StatefulWidget {
  final ZkLoginProvider provider;

  const StepTwoPage({
    super.key,
    required this.provider,
  });

  @override
  State<StepTwoPage> createState() => _StepTwoPageState();
}

class _StepTwoPageState extends State<StepTwoPage> {
  ZkLoginProvider get provider => widget.provider;

  SuiAccount? get account => provider.account;

  bool get click => provider.maxEpoch > 0 && provider.randomness.isNotEmpty;

  FlutterMacOSWebView? macOsWebView;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: provider.getCurrentEpoch(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          provider.randomness = generateRandomness();
          provider.nonce = generateNonce(
            account!.keyPair.getPublicKey(),
            provider.maxEpoch,
            provider.randomness,
          );

          return Container(
            // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(8),
            //   border: Border.all(
            //     color: AppTheme.dividerColor,
            //     width: 1,
            //   ),
            // ),
            child: _signInWidget(context),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('error'),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  _signInWidget(
    BuildContext context,
  ) {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.vertical,
      runAlignment: WrapAlignment.center,
      runSpacing: 15,
      spacing: 15,
      children: [
        _signInButton(context, 'apple.svg', 'Apple'),
        _signInButton(context, 'google.svg', 'Google'),
      ],
    );
  }

  _signInButton(BuildContext context, String svg, String name) {
    return ElevatedButton(
      onPressed: provider.nonce.isEmpty || provider.jwt.isNotEmpty
          ? null
          : () async {
              if (name == 'Apple') {
                final result = await SignInWithApple.getAppleIDCredential(
                    scopes: [AppleIDAuthorizationScopes.email],
                    nonce: provider.nonce,
                    // only for web
                    webAuthenticationOptions: WebAuthenticationOptions(
                        clientId: 'com.mofalabs.zklogin-dart-demo',
                        redirectUri: Uri.parse(Constant.redirectUrl)));
                provider.jwt = result.identityToken ?? '';
                provider.userIdentifier = result.userIdentifier ?? '';
                provider.email = result.email ?? '';
                provider.step = provider.step + 1;
              } else {
                html.window.location.href = provider.googleLoginUrl;
              }
            },
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: const EdgeInsets.all(18),
        backgroundColor: AppTheme.buttonColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      child: SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/$svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 15),
            Text(
              'Sign in with $name',
              style: const TextStyle(fontSize: 15),
            )
          ],
        ),
      ),
    );
  }
}
