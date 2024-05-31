import 'package:animate_gradient/animate_gradient.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:drag_anim/drag_anim.dart';
import 'package:drag_anim/drag_anim_notification.dart';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';
import 'package:provider/provider.dart';
import 'package:sui/types/objects.dart';
import 'package:webio/model/component_model.dart';
import 'package:webio/model/ticket_model.dart';
import 'package:webio/nft_page.dart';
import 'package:webio/pick_upload_image.dart';
import 'package:webio/provider/zk_login_provider.dart';
import 'package:webio/widget/my_drop_down.dart';

import 'data/constants.dart';

class HomePage extends StatefulWidget {
  final List<ComponentModel> componentList;
  const HomePage({super.key, required this.componentList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TextEditingController> nameControllerList = [];
  final List<TextEditingController> desControllerList = [];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    for (int i = 0; i < nameControllerList.length; i++) {
      nameControllerList[i].dispose();
      desControllerList[i].dispose();
    }
  }

  final ZkLoginProvider provider = ZkLoginProvider.getInstance();

  Color color = const Color(0xff1a191b);
  bool shareBtnHover = false;
  late final List<HomeEditCard> list;
  Widget _getText() {
    const colorizeColors = [
      Colors.green,
      Colors.greenAccent,
      Colors.lightGreenAccent,
      Colors.grey,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 50.0,
      fontFamily: 'Horizon',
    );

    return SizedBox(
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            'Wenimal Team',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            'Webio',
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            provider.address,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
  }

  Widget _buildCardItem(ComponentModel componentModel, BuildContext context) {
    return GestureDetector(
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
                  child: componentModel.imageUrl == null
                      ? null
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FadeInImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(componentModel.imageUrl!),
                            placeholder:
                                const AssetImage('assets/images/logo.png'),
                            imageErrorBuilder: (context, error, stackTrace) {
                              print('imageErrorBuilder: $error');
                              return SizedBox(
                                width: double.maxFinite,
                                child: Image.asset(
                                  'assets/images/logo2.png',
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
                                componentModel.name ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                componentModel.description ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.componentList.isNotEmpty) {
      for (ComponentModel componentModel in widget.componentList) {
        nameControllerList
            .add(TextEditingController(text: componentModel.name));
        desControllerList
            .add(TextEditingController(text: componentModel.description));
      }
    }
    list =
        // widget.componentList.isNotEmpty
        //     ?
        widget.componentList
            .map((e) => HomeEditCard(
                key: e.id!,
                mainAxisCellCount: 2,
                crossAxisCellCount: 3,
                widget: _buildCardItem(e, context)))
            .toList();
    newComponentList = List.from(widget.componentList);
  }

  late List<ComponentModel> newComponentList;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.96;
    var width = MediaQuery.of(context).size.width * 0.96;

    return Consumer<ZkLoginProvider>(
      builder: (_, v, __) {
        return Scaffold(
          backgroundColor: const Color(0xff121113),
          body: Stack(
            children: [
              DragAnimNotification(
                child: Center(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: ListView(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        DragAnim<HomeEditCard>(
                          scrollDirection: Axis.horizontal,
                          buildItems: (List<Widget> children) {
                            return StaggeredGrid.count(
                              crossAxisCount: _getResize(),
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              children: children,
                            );
                          },
                          items: (HomeEditCard element, DragItems dragItems) {
                            return StaggeredGridTile.count(
                              key: ValueKey<String>(element.key ?? ''),
                              mainAxisCellCount: element.mainAxisCellCount,
                              crossAxisCellCount: element.crossAxisCellCount,
                              child: dragItems(
                                MouseRegion(
                                  onHover: (event) {
                                    setState(() {
                                      element.isHover = true;
                                    });
                                  },
                                  onExit: (event) {
                                    setState(() {
                                      element.isHover = false;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        margin: element.isHover
                                            ? EdgeInsets.zero
                                            : const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: const Color(0xff1a191b),
                                            borderRadius:
                                                BorderRadius.circular(36),
                                            border: Border.all(
                                                width: 3,
                                                color: element.isHover
                                                    ? Colors.green
                                                    : const Color(0xff323035))),
                                        alignment: Alignment.center,
                                        child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: element.widget),
                                      ),
                                      if (element.isHover)
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        int index =
                                                            newComponentList
                                                                .indexWhere((e) =>
                                                                    e.id ==
                                                                    element
                                                                        .key);
                                                        newComponentList
                                                            .removeAt(index);
                                                        list.remove(element);
                                                        nameControllerList
                                                            .removeAt(index);
                                                        desControllerList
                                                            .removeAt(index);
                                                        print(
                                                            'widget.componentList.length: ${widget.componentList.length}');
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    color: Colors.white,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          element.mainAxisCellCount =
                                                              1;
                                                          element.crossAxisCellCount =
                                                              1;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.square_outlined,
                                                        size: 16,
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          element.mainAxisCellCount =
                                                              2;
                                                          element.crossAxisCellCount =
                                                              3;
                                                        });
                                                      },
                                                      icon: const Icon(Icons
                                                          .rectangle_outlined),
                                                      color: Colors.white,
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          element.mainAxisCellCount =
                                                              4;
                                                          element.crossAxisCellCount =
                                                              3;
                                                        });
                                                      },
                                                      icon: const ImageIcon(
                                                        AssetImage(
                                                          'assets/images/rectangle_vertical.png',
                                                        ),
                                                        size: 24,
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          // buildFeedback: (data, child, size) {
                          //   return Container(
                          //     width: 250,
                          //     height: 250,
                          //     color: Colors.red,
                          //   );
                          // },
                          dataList: list,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      MyDropDown(),
                      MouseRegion(
                        onHover: (event) {
                          setState(() {
                            shareBtnHover = true;
                          });
                        },
                        onExit: (event) {
                          setState(() {
                            shareBtnHover = false;
                          });
                        },
                        child: GestureDetector(
                          onTap: () async {
                            for (int i = 0; i < newComponentList.length; i++) {
                              newComponentList[i].name =
                                  nameControllerList[i].text;
                              newComponentList[i].description =
                                  desControllerList[i].text;
                              print('add com: ${newComponentList[i].toJson()}');
                              await provider.executeMintAndTake(
                                  context, newComponentList[i]);
                            }
                            print(
                                'widget.componentList.length: ${widget.componentList.length}');
                            for (ComponentModel e in widget.componentList) {
                              await provider.executeRemove(context, e.id!);
                              print('remove ${e.id}');
                            }
                            html.window.location.href =
                                '${Constant.website}/#/profile/${provider.address}';
                          },
                          child: Container(
                            margin: const EdgeInsets.all(16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AnimateGradient(
                                primaryBeginGeometry:
                                    const AlignmentDirectional(0, 1),
                                primaryEndGeometry:
                                    const AlignmentDirectional(0, 2),
                                secondaryBeginGeometry:
                                    const AlignmentDirectional(2, 0),
                                secondaryEndGeometry:
                                    const AlignmentDirectional(0, -0.8),
                                textDirectionForGeometry: TextDirection.rtl,
                                primaryColors: shareBtnHover
                                    ? [Colors.green, Colors.green, Colors.green]
                                    : const [
                                        Colors.green,
                                        Colors.greenAccent,
                                        Colors.white,
                                      ],
                                secondaryColors: shareBtnHover
                                    ? [Colors.green, Colors.green, Colors.green]
                                    : const [
                                        Colors.white,
                                        Colors.lightGreen,
                                        Colors.lightGreenAccent,
                                      ],
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Share My Profile',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          _addCardItem(
                              crossAxisCellCount: 1, mainAxisCellCount: 1);
                        },
                        icon: const Icon(
                          Icons.square_outlined,
                          size: 16,
                        ),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          _addCardItem(
                              crossAxisCellCount: 3, mainAxisCellCount: 2);
                        },
                        icon: const Icon(Icons.rectangle_outlined),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          _addCardItem(
                              crossAxisCellCount: 3, mainAxisCellCount: 4);
                        },
                        icon: const ImageIcon(
                          AssetImage(
                            'assets/images/rectangle_vertical.png',
                          ),
                          size: 24,
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getTextCard() {
    TextEditingController nameComtroller =
        TextEditingController(text: 'flamrdevs');
    TextEditingController desController =
        TextEditingController(text: 'UI/UX designer');
    nameControllerList.add(nameComtroller);
    desControllerList.add(desController);
    return Material(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLines: null,
                controller: nameComtroller,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                  filled: true,
                  hoverColor: Colors.grey,
                  border: InputBorder.none,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                maxLines: null,
                controller: desController,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                  filled: true,
                  hoverColor: Colors.grey,
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                maxLines: null,
                controller: TextEditingController(
                  text:
                      'I am a UI/UX designer from Indonesia, specializing in creating user-centric and visually appealing digital experiences. With a focus on seamless and enjoyable interactions, I aim to enhance the overall user experience through strategic design solutions.',
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                  filled: true,
                  hoverColor: Colors.grey,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addCardItem(
      {required num mainAxisCellCount, required int crossAxisCellCount}) {
    HomeEditCard homeEditCard = HomeEditCard(
      key: 'card ${list.length}',
      mainAxisCellCount: mainAxisCellCount,
      crossAxisCellCount: crossAxisCellCount,
    );
    homeEditCard.widget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              homeEditCard.widget = _getTextCard();
            });
          },
          icon: const Icon(
            Icons.text_format_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () async {
            FilePickerResult? image = await pickImage();
            if (image != null) {
              setState(() {
                homeEditCard.widget = Image.memory(
                  image.files.first.bytes!,
                  fit: BoxFit.cover,
                );
              });
            }
          },
          icon: const Icon(
            Icons.image_outlined,
            size: 40,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () async {
            TicketModel ticketModel = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NftPage(),
                ));
            setState(() {
              homeEditCard.widget = _buildNftItem(ticketModel, context);
            });
          },
          icon: const ImageIcon(
            AssetImage(
              'assets/images/nft.png',
            ),
            size: 24,
          ),
          color: Colors.white,
        ),
      ],
    );
    list.add(homeEditCard);
    newComponentList.add(ComponentModel(
      id: homeEditCard.key,
      name: '',
      description: '',
    ));
  }

  Widget _buildNftItem(TicketModel ticketModel, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pop(context, ticketModel);
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
                      image: NetworkImage(ticketModel.url ?? ''),
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
                              subtitle: Text(
                                ticketModel.description ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
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

  int _getResize() {
    var size = MediaQuery.of(context).size.width;
    if (size > 1500) {
      return 9;
    }
    if (size > 950) {
      return 6;
    }
    return 3;
  }
}

class HomeEditCard {
  final String key;
  num mainAxisCellCount;
  int crossAxisCellCount;
  bool isHover = false;
  Widget? widget;

  HomeEditCard(
      {required this.key,
      required this.mainAxisCellCount,
      required this.crossAxisCellCount,
      this.widget});
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    ZkLoginProvider provider = ZkLoginProvider.getInstance();

    return FutureBuilder(
      future: _getCardList(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<ComponentModel> cardList = snapshot.data!;
          return HomePage(
            componentList: cardList,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<ComponentModel>> _getCardList(BuildContext context) async {
    List<ComponentModel> componentList = [];
    ZkLoginProvider provider = ZkLoginProvider.getInstance();

    List<String>? components = await provider.executeGetComponent(context);
    if (components != null) {
      for (String objectId in components) {
        SuiObjectResponse suiObjectResponse =
            await provider.suiClient.getObject(
          objectId,
          options: SuiObjectDataOptions(showContent: true, showType: true),
        );
        SuiObject suiObject = suiObjectResponse.data!;
        ComponentModel componentModel = ComponentModel.fromJson(
            suiObject.content?.fields as Map<String, dynamic>);
        print('componentModel: ${componentModel.toJson()}');
        if (componentModel.isActive == true) {
          print('componentModel True: ${componentModel.toJson()}');

          componentList.add(componentModel);
        }
      }
    }
    return componentList;
  }
}
