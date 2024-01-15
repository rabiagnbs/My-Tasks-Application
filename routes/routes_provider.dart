
import 'package:calismalarim_app/TasksApp/routes/route_location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_routes.dart';


final routesProvider = Provider<GoRouter>((ref){
  return GoRouter(
    initialLocation: RouteLocation.home,
      navigatorKey: navigationKey,
      routes: appRoutes,
  );
 },
);