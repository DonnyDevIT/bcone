import 'package:auto_route/auto_route.dart';
import 'package:bcone/routes/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      // list of your tab routes
      // routes used here must be declared as children
      // routes of /dashboard
      routes: const [
        HomeRoute(),
        BusinessRoute(),
        SchoolRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(
        opacity: animation,
        // the passed child is technically our animated selected-tab page
        child: child,
      ),
      builder: (context, child) {
        // obtain the scoped TabsRouter controller using context
        final tabsRouter = AutoTabsRouter.of(context);
        // Here we're building our Scaffold inside of AutoTabsRouter
        // to access the tabsRouter controller provided in this context
        //
        // alternatively, you could use a global key
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              // here we switch between tabs
              tabsRouter.setActiveIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                label: 'Tavoli',
                icon: Icon(tabsRouter.activeIndex == 0
                    ? Icons.table_bar
                    : Icons.table_bar_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Business',
                icon: Icon(Icons.business),
              ),
              BottomNavigationBarItem(
                label: 'School',
                icon: Icon(Icons.school),
              ),
            ],
          ),
        );
      },
    );
  }
}
