import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:gettext/gettext.dart";

import 'package:package_info_plus/package_info_plus.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';

import 'package:lobby/global_router.dart';
import 'package:lobby/bloc/user/user.dart';
import 'package:lobby/bloc/settings/settings.dart';

class LoginScreen extends StatelessWidget {
  static final route = buildRoute(
      key: routeLogin,
      uri: "/login",
      route: (context) => MaterialPageRoute(
            settings: context,
            builder: (context) => const LoginScreen(),
          ));

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final assets = [
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen1.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen2.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen3.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen4.png'),
          fit: BoxFit.fill),
      const Image(
          image: AssetImage('assets/fsbackground/loadscreen5.png'),
          fit: BoxFit.fill),
    ];

    return BlocBuilder<SettingsBloc, SettingsState>(builder: (scontext, state) {
      return BlocBuilder<UserBloc, UserState>(builder: (context, ustate) {
        final packageInfo = RepositoryProvider.of<PackageInfo>(context);
        final gt = RepositoryProvider.of<Gettext>(context);
        final userBloc = BlocProvider.of<UserBloc>(context);

        FormGroup buildForm() => fb.group(<String, Object>{
              'username': FormControl<String>(
                validators: [Validators.required, Validators.minLength(4)],
                value: ustate.name,
              ),
              'password': ['', Validators.required, Validators.minLength(8)],
            });

        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Carousel(
                animationCurve: Curves.linear,
                showIndicator: false,
                autoplayDuration: const Duration(seconds: 60),
                images: assets,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "${packageInfo.appName} ${packageInfo.version}-${packageInfo.buildNumber} (${Theme.of(context).platform.name})",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 450,
                      width: 350,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ReactiveFormBuilder(
                          form: buildForm,
                          builder: (context, form, child) {
                            return Scaffold(
                              appBar: AppBar(
                                leading: IconButton(
                                  onPressed: () => {},
                                  icon: const Image(
                                    color: null,
                                    image: AssetImage('assets/logo.png'),
                                  ),
                                ),
                                title: Text(gt.gettext("Login")),
                              ),
                              body: Center(
                                // Center is a layout widget. It takes a single child and positions it
                                // in the middle of the parent.
                                child: Padding(
                                  padding: const EdgeInsets.all(25.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      DropdownButton(
                                        value: state.locale != null
                                            ? state.locale!
                                            : "en-US",
                                        onChanged: (value) {
                                          if (value == null) {
                                            return;
                                          }

                                          final sBloc =
                                              BlocProvider.of<SettingsBloc>(
                                                  context);
                                          sBloc.add(ChangeLocale(value));
                                        },
                                        items: locales.entries
                                            .map<DropdownMenuItem<String>>(
                                                (entry) =>
                                                    DropdownMenuItem<String>(
                                                        value: entry.key,
                                                        child:
                                                            Text(entry.value)))
                                            .toList(),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ReactiveTextField<String>(
                                        formControlName: 'username',
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              gt.gettext(
                                                  'The username must not be empty'),
                                          ValidationMessage.minLength: (_) =>
                                              gt.gettext(
                                                  'The username must be at least 4 characters'),
                                        },
                                        textInputAction: TextInputAction.next,
                                        autofocus: true,
                                        onSubmitted: (control) {
                                          if (!control.valid) {
                                            return;
                                          }
                                          userBloc
                                              .add(SetUsername(control.value!));
                                          form.focus('password');
                                        },
                                        decoration: InputDecoration(
                                          labelText: gt.gettext("Username"),
                                          helperText: '',
                                          helperStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!,
                                          errorStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                      const SizedBox(height: 16.0),
                                      ReactiveTextField<String>(
                                        formControlName: 'password',
                                        obscureText: true,
                                        validationMessages: {
                                          ValidationMessage.required: (_) =>
                                              gt.gettext(
                                                  'The password must not be empty'),
                                          ValidationMessage.minLength: (_) =>
                                              gt.gettext(
                                                  'The password must be at least 8 characters'),
                                        },
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          labelText: gt.gettext("Password"),
                                          helperText: '',
                                          helperStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!,
                                          errorStyle: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              floatingActionButton: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25.0, 0, 0, 0),
                                child: Row(
                                  children: [
                                    FloatingActionButton(
                                      onPressed: () {},
                                      heroTag: null,
                                      tooltip: gt.gettext("Password"),
                                      child: const Icon(
                                        Icons.app_registration_rounded,
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: FloatingActionButton(
                                        heroTag: null,
                                        onPressed: () => form.resetState(
                                          {
                                            'username': ControlState<String>(
                                                value: null),
                                            'password': ControlState<String>(
                                                value: null),
                                          },
                                          removeFocus: true,
                                        ),
                                        tooltip: gt.gettext("Clear"),
                                        child: const Icon(
                                          Icons.delete,
                                          size: 18.0,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    FloatingActionButton(
                                      onPressed: () {
                                        if (form.valid) {
                                          userBloc.add(
                                            SetUsername(
                                                form.control('username').value),
                                          );
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  GlobalRouter()
                                                      .buildUri(routeHome));
                                        } else {
                                          form.markAllAsTouched();
                                        }
                                      },
                                      tooltip: gt.gettext("Login"),
                                      child: const Icon(
                                        Icons.login,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      });
    });
  }
}
