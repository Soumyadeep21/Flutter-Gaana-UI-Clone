import 'package:flutter/material.dart';
import 'package:gaana/pages/home_page.dart';
import 'package:gaana/pages/my_music_page.dart';
import 'package:gaana/pages/radio_page.dart';
import 'package:gaana/pages/search_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with TickerProviderStateMixin {
  TabController controller, homeController;
  Widget _currentPage;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this, initialIndex: 1);
    homeController = TabController(length: 4, vsync: this);
    _currentPage = HomePage();
    homeController
      ..addListener(() {
        setState(() {
          switch (homeController.index) {
            case 0:
              _currentPage = HomePage();
              break;
            case 1:
              _currentPage = SearchPage();
              break;
            case 2:
              _currentPage = RadioPage();
              break;
            case 3:
              _currentPage = MyMusicPage();
              break;
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [forYouPage(), mainHomePage()],
      controller: controller,
      physics: ClampingScrollPhysics(),
    );
  }

  Widget forYouPage() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: Text("gaana"),
          backgroundColor: ThemeData.dark().canvasColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                controller.animateTo(1);
              },
            )
          ],
        )
      ],
    );
  }

  Widget mainHomePage() {
    return Scaffold(
      bottomNavigationBar: TabBar(
          controller: homeController,
          labelColor: Colors.red,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(
              icon: Icon(MdiIcons.homeOutline),
              text: "Home",
            ),
            Tab(
              icon: Icon(MdiIcons.microphone),
              text: "Search",
            ),
            Tab(
              icon: Icon(MdiIcons.radio),
              text: "Radio",
            ),
            Tab(
              icon: Icon(MdiIcons.musicBoxOutline),
              text: "My Music",
            )
          ]),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            titleSpacing: 0.0,
            backgroundColor: ThemeData.dark().canvasColor,
            elevation: 0.0,
            title: GestureDetector(
              onTap: () {
                controller.animateTo(0);
              },
              child: Row(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 100,
                      width: 20,
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10.0),
                              topRight: Radius.circular(10.0))),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 13.0,
                      ),
                    ),
                  ),
                  Text(
                    "gaana",
                    style: TextStyle(color: Colors.grey[600], fontSize: 25),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(MdiIcons.libraryVideo), onPressed: () {}),
              IconButton(icon: Icon(MdiIcons.settingsOutline), onPressed: () {})
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate([_currentPage]),
          )
        ],
      ),
    );
  }
}
