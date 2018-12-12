import 'package:flutter/material.dart';

class FooPage extends StatefulWidget {
  @override
  _FooState createState() => new _FooState();
}

class _FooState extends State<FooPage>
    with AutomaticKeepAliveClientMixin<FooPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(child: Text('foo'));
  }
}

class BarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('bar'));
  }
}

class HomePageTopBar extends StatefulWidget implements PreferredSizeWidget {
  HomePageTopBar({Key key, this.tabbar})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  final Widget tabbar;

  @override
  final Size preferredSize;

  @override
  _HomePageTopBarState createState() => _HomePageTopBarState();
}

class _HomePageTopBarState extends State<HomePageTopBar> {
  @override
  Widget build(BuildContext context) {
    final Widget toolbar = NavigationToolbar(leading: widget.tabbar);
    return toolbar;
  }
}

void main() {
  runApp(
    MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
            appBar: HomePageTopBar(
              tabbar: TabBar(
                labelColor: Colors.white,
                indicator: BoxDecoration(),
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 20.0),
                tabs: [Text('foo'), Text('bar')],
              ),
            ),
            body: TabBarView(
              children: <Widget>[FooPage(), BarPage()],
            ),
          ),
        ),
      ),
    ),
  );
}
