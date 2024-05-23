import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/entities/order_update_entity.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:webio/pick_upload_image.dart';

import 'my_item.dart';

class MyGrid extends StatefulWidget {
  const MyGrid({super.key});

  @override
  State<MyGrid> createState() => MyGridState();
}

class MyGridState extends State<MyGrid> {
  final _scrollController = ScrollController();
  final _gridViewKey = GlobalKey();
  final _fruits = <Object>[
    "apple",
    "banana",
    "strawberry",
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
  ];

  final myItemList = [
    Container(
      key: const Key('item 1'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 2'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 3'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 4'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 5'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 6'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 7'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 8'),
      color: Colors.red,
    ),
    Container(
      key: const Key('item 9'),
      color: Colors.red,
    ),
  ];

  void addItem() async {
    FilePickerResult? image = await pickImage();
    if (image != null) {
      for (int i = 0; i < _fruits.length; i++) {
        if (_fruits[i] is! MyItem) {
          setState(() {
            _fruits[0] = image.files.first.name;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return ReorderableBuilder(
      enableLongPress: false,
      scrollController: _scrollController,
      onReorder: (List<OrderUpdateEntity> orderUpdateEntities) {
        for (final orderUpdateEntity in orderUpdateEntities) {
          final fruit = _fruits.removeAt(orderUpdateEntity.oldIndex);
          _fruits.insert(orderUpdateEntity.newIndex, fruit);
        }
      },
      builder: (children) {
        return GridView(
          key: _gridViewKey,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisCount: 3,
            mainAxisSpacing: 3,
            crossAxisSpacing: 8,
          ),
          children: children,
        );
      },
      children: myItemList,
    );
  }
}
