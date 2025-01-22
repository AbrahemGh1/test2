import 'package:flareline_crm/deferred_widget.dart';
import 'package:flareline_crm/pages/auth/sign_in/sign_in_page.dart'
    deferred as signIn;
import 'package:flareline_crm/pages/auth/sign_up/sign_up_page.dart'
    deferred as signUp;
import 'package:flareline_crm/pages/calendar/day_calendar_page.dart'
    deferred as dayCalendar;
import 'package:flareline_crm/pages/calendar/month_calendar_page.dart'
    deferred as monthCalendar;
import 'package:flareline_crm/pages/calendar/week_calendar_page.dart'
    deferred as weekCalendar;
import 'package:flareline_crm/pages/costs/cost_page.dart' deferred as costPage;
import 'package:flareline_crm/pages/deals/deals_page.dart' deferred as deals;
import 'package:flareline_crm/pages/home/crm_home_page.dart';
import 'package:flareline_crm/pages/integrations/integrations_page.dart'
    deferred as integrations;
import 'package:flareline_crm/pages/patients/patient_profile_page.dart'
    deferred as patientProfilePage;
import 'package:flareline_crm/pages/patients/patients_page.dart'
    deferred as patients;
import 'package:flareline_crm/pages/report/report_page.dart' deferred as report;
import 'package:flareline_crm/pages/settings/user_settings_page.dart'
    deferred as userSettings;
import 'package:flareline_crm/pages/task/task_page.dart' deferred as task;
import 'package:flareline_crm/pages/therapist/therapist_page.dart'
    deferred as therapist;
import 'package:flutter/material.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String?);

final List<Map<String, Object>> MAIN_PAGES = [
  {'routerPath': '/', 'widget': CrmHomePage()},
  {
    'routerPath': '/signIn',
    'widget': DeferredWidget(signIn.loadLibrary, () => signIn.SignInPage())
  },
  {
    'routerPath': '/signUp',
    'widget': DeferredWidget(signUp.loadLibrary, () => signUp.SignUpPage())
  },
  {
    'routerPath': '/patients',
    'widget':
        DeferredWidget(patients.loadLibrary, () => patients.PatientsPage())
  },
  {
    'routerPath': '/therapist',
    'widget':
        DeferredWidget(therapist.loadLibrary, () => therapist.TherapistPage())
  },
  {
    'routerPath': '/deals',
    'widget': DeferredWidget(deals.loadLibrary, () => deals.DealsPage())
  },
  {
    'routerPath': '/task',
    'widget': DeferredWidget(task.loadLibrary, () => task.TasksPage())
  },
  {
    'routerPath': '/userSettings',
    'widget': DeferredWidget(
        userSettings.loadLibrary, () => userSettings.UserSettingsPage())
  },
  {
    'routerPath': '/integrations',
    'widget': DeferredWidget(
        integrations.loadLibrary, () => integrations.IntegrationsPage())
  },
  {
    'routerPath': '/report',
    'widget': DeferredWidget(report.loadLibrary, () => report.ReportPage())
  },
  {
    'routerPath': '/day',
    'widget': DeferredWidget(
        dayCalendar.loadLibrary, () => dayCalendar.DayCalendarPage())
  },
  {
    'routerPath': '/week',
    'widget': DeferredWidget(
        weekCalendar.loadLibrary, () => weekCalendar.WeekCalendarPage())
  },
  {
    'routerPath': '/month',
    'widget': DeferredWidget(
        monthCalendar.loadLibrary, () => monthCalendar.MonthCalendarPage())
  },
  {
    'routerPath': '/cost',
    'widget': DeferredWidget(costPage.loadLibrary, () => costPage.CostPage())
  },
  {
    'routerPath': '/patientProfilePage',
    'widget': DeferredWidget(patientProfilePage.loadLibrary,
        () => patientProfilePage.PatientsProfilePage(patientId: 1))
  },
];

class RouteConfiguration {
  static final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>(debugLabel: 'Rex');

  static BuildContext? get navigatorContext =>
      navigatorKey.currentState?.context;

  static Route<dynamic>? onGenerateRoute(
    RouteSettings settings,
  ) {
    String path = settings.name!;

    dynamic map =
        MAIN_PAGES.firstWhere((element) => element['routerPath'] == path);

    if (map == null) {
      return null;
    }
    Widget targetPage = map['widget'];

    builder(context, match) {
      return targetPage;
    }

    return NoAnimationMaterialPageRoute<void>(
      builder: (context) => builder(context, null),
      settings: settings,
    );
  }
}

class NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  NoAnimationMaterialPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
