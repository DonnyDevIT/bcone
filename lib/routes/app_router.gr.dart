// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:bcone/app/pages/business_page.dart' as _i1;
import 'package:bcone/app/pages/home/home_page.dart' as _i2;
import 'package:bcone/app/pages/main_page.dart' as _i3;
import 'package:bcone/app/pages/school_page.dart' as _i4;

/// generated route for
/// [_i1.BusinessPage]
class BusinessRoute extends _i5.PageRouteInfo<void> {
  const BusinessRoute({List<_i5.PageRouteInfo>? children})
      : super(
          BusinessRoute.name,
          initialChildren: children,
        );

  static const String name = 'BusinessRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.BusinessPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainPage();
    },
  );
}

/// generated route for
/// [_i4.SchoolPage]
class SchoolRoute extends _i5.PageRouteInfo<void> {
  const SchoolRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SchoolRoute.name,
          initialChildren: children,
        );

  static const String name = 'SchoolRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SchoolPage();
    },
  );
}
