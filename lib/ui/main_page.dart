import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import '../model/model_class.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Outer list
  List<DragAndDropList> _lists = [];
  String currentTab = 'H O M E';

  List<ModelClass> iconList = [
    ModelClass('assets/images/home.png', 'H O M E'),
    ModelClass('assets/images/menu.png', 'M E N U'),
    ModelClass('assets/images/bell.png', 'N O T I F I C A T I O N'),
    ModelClass('assets/images/user.png', 'P R O F I L E'),
  ];

  @override
  void initState() {
    super.initState();
    _initializeLists();
  }

  _initializeLists() {
    _lists = List.generate(iconList.length, (listIndex) {
      return DragAndDropList(
        canDrag: true,
        header: GestureDetector(
          onTap: () {
            setState(() {
              currentTab = iconList[listIndex].pageName.toString();
            });
          },
          child: Container(
            width: 40,
            height: 40,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(6)),
            child: Image.asset(iconList[listIndex].image.toString()),
          ),
        ),
        children: [DragAndDropItem(canDrag: false, child: const SizedBox())],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('T A S K', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor),
      body: Center(child: Text(currentTab.toString())),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.only(left: 15, right: 10),
        alignment: Alignment.center,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: DragAndDropLists(
          axis: Axis.horizontal,
          children: _lists,
          onItemReorder: _onItemReorder,
          onListReorder: _onListReorder,
          listPadding: const EdgeInsets.all(8.0),
          listWidth: 95,
          itemDecorationWhileDragging: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
        ),
      ),
    );
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex].children.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      _lists.insert(newListIndex, movedList);
    });
  }


}
