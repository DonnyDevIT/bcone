import 'package:auto_route/auto_route.dart';
import 'package:bcone/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(path: 'home', page: HomeRoute.page),
            AutoRoute(path: 'business', page: BusinessRoute.page),
            AutoRoute(path: 'school', page: SchoolRoute.page)
          ],
        ),
      ];
}
