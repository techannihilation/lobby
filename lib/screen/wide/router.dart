import '../../global_router.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'fourofour_screen.dart';

void registerWideRoutes() {
  GlobalRouter().add(LoginScreen.route);
  GlobalRouter().add(HomeScreen.route);
  GlobalRouter().add(FourOFourScreen.route);

  assert(GlobalRouter().validateRoutes());
}
