import 'package:flutter/material.dart';

class FooPage extends StatefulWidget {
  @override
  _FooState createState() => new _FooState();
}

class _FooState extends State<FooPage>
    with AutomaticKeepAliveClientMixin<FooPage> {
  @override
  bool get wantKeepAlive => true;

  Widget _buildList() {
    return ListView.builder(
      itemCount: 40,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 25.0),
          margin: EdgeInsets.only(bottom: 10.0),
          color: Colors.white,
          child: Text("Number $i"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildList();
  }
}

class BarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('bar'));
  }
}

class HomePageTopBar extends StatefulWidget implements PreferredSizeWidget {
  HomePageTopBar({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _HomePageTopBarState createState() => _HomePageTopBarState();
}

class _HomePageTopBarState extends State<HomePageTopBar> {
  Widget _buildUserInfo() {
    Widget userInfo = Row(
      children: <Widget>[
        Flexible(
          flex: 0,
          child: Text(
            '未登录',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ),
        Flexible(
          flex: 0,
          child: CircleAvatar(
            radius: 24.0,
            backgroundImage: AssetImage('assets/default_avatar.png'),
            backgroundColor: Colors.white,
          ),
        ),
      ],
    );
    return userInfo;
  }

  Widget _buildTabbar() {
    Widget tabbar = TabBar(
      isScrollable: false,
      labelPadding: EdgeInsets.zero,
      labelColor: Colors.black,
      indicator: BoxDecoration(),
      indicatorWeight: 0,
      unselectedLabelColor: const Color(0xFFC7C7C7),
      labelStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      tabs: [
        Text('种草'),
        Text('关注'),
      ],
    );
    tabbar = Container(
      constraints: BoxConstraints(maxWidth: 136.0),
      child: tabbar,
    );
    return tabbar;
  }

  @override
  Widget build(BuildContext context) {
    Widget homePageTopBar = Row(
      children: <Widget>[
        Flexible(
          flex: 0,
          child: _buildTabbar(),
        ),
        Spacer(),
        Flexible(
          flex: 0,
          child: _buildUserInfo(),
        ),
      ],
    );

    homePageTopBar = Container(
      padding: EdgeInsets.symmetric(horizontal: 21.0),
      constraints: BoxConstraints(maxHeight: 88.0),
      child: homePageTopBar,
    );

    homePageTopBar = SafeArea(
      top: true,
      child: homePageTopBar,
    );

    return homePageTopBar;
  }
}

void main() {
  runApp(
    MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: HomePageTopBar(),
          body: Container(
            color: Color(0xFFF7F7F7),
            child: TabBarView(
              children: <Widget>[FooPage(), BarPage()],
            ),
          ),
        ),
      ),
    ),
  );
}
