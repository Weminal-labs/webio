import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sui/sui.dart';
import 'package:synchronized/synchronized.dart';
import 'package:webio/model/ticket_model.dart';
import 'package:webio/provider/zk_login_provider.dart';
import 'package:webio/widget/background_widget.dart';

void main() {
  final ZkLoginProvider provider = ZkLoginProvider.getInstance();
  provider.suiClient = SuiClient(SuiUrls.testnet);
  provider.address =
      '0x78b265cc9f4c4eb59c344f13a11f32fe816176bb30d75a90b48763983eb81d35';
  runApp(MaterialApp(
    home: NftPage(),
  ));
}

class NftPage extends StatefulWidget {
  const NftPage({super.key});

  @override
  State<NftPage> createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> {
  GlobalKey<BackgroundWidgetState> bgKey = GlobalKey();
  List<NetworkImage> networkImages = [];
  List<TicketModel> ticketModels = [];
  final ZkLoginProvider provider = ZkLoginProvider.getInstance();

  void changeBackground(NetworkImage networkImage, String? name, String? des) {
    bgKey.currentState
        ?.setContent(networkImage: networkImage, name: name, des: des);
  }

  @override
  Widget build(BuildContext context) {
    networkImages.clear();
    ticketModels.clear();
    return Stack(
      children: [
        BackgroundWidget(
          key: bgKey,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: FutureBuilder(
            future: provider.suiClient.getOwnedObjects(provider.address),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SuiObjectResponse> objects = snapshot.data!.data;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          padEnds: false,
                          height: 400.0,
                          viewportFraction: 0.8,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) async {
                            changeBackground(
                                networkImages[index],
                                ticketModels[index].name,
                                ticketModels[index].description);
                          },
                        ),
                        items: objects.map((i) {
                          return FutureBuilder(
                            future: provider.suiClient.getObject(
                                i.data?.objectId ?? '',
                                options: SuiObjectDataOptions(
                                    showContent: true, showType: true)),
                            builder: (BuildContext context,
                                AsyncSnapshot<SuiObjectResponse> snapshot) {
                              if (snapshot.hasData) {
                                SuiObject? object = snapshot.data!.data;

                                TicketModel ticketModel = TicketModel.fromJson(
                                    object?.content?.fields
                                        as Map<String, dynamic>);
                                if (object?.type ==
                                    '0x2::coin::Coin<0x2::sui::SUI>') {
                                  ticketModel.url = 'assets/images/sui.png';
                                  ticketModel.name = 'SUI coins';
                                }
                                NetworkImage networkImage = NetworkImage(
                                    ticketModel.url ?? 'assets/images/sui.png');

                                if (networkImages.isEmpty) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    changeBackground(
                                        networkImage,
                                        ticketModel.name,
                                        ticketModel.description);
                                  });
                                }
                                if (networkImages.length < objects.length) {
                                  networkImages.add(networkImage);
                                  ticketModels.add(ticketModel);
                                }

                                return _buildNftItem(
                                    ticketModel, networkImage, context);
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error'),
                                );
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNftItem(TicketModel ticketModel, NetworkImage networkImage,
      BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, ticketModel);
      },
      child: Card(
        color: Colors.grey,
        elevation: 5,
        shadowColor: Colors.grey,
        child: SizedBox(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: double.maxFinite,
                  foregroundDecoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black12,
                        Colors.black26,
                        Colors.black38,
                        Colors.black45,
                        Colors.black54,
                        Colors.black87,
                      ],
                      tileMode: TileMode.mirror,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.4, 0.55, 0.65, 0.75, 0.8, 0.85, 1],
                    ),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                    // image: DecorationImage(image: randomImage, fit: BoxFit.fill),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      image: networkImage,
                      placeholder: const AssetImage('assets/images/logo.png'),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return SizedBox(
                          width: double.maxFinite,
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                ticketModel.name ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
