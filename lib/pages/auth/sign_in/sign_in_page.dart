import 'package:flareline_crm/core/theme/crm_colors.dart';
import 'package:flareline_crm/pages/auth/sign_in/sign_in_state.dart';
import 'package:flareline_crm/pages/auth/sign_in/sign_in_viewmodel.dart';
import 'package:flareline_uikit/components/buttons/button_widget.dart';
import 'package:flareline_uikit/components/card/common_card.dart';
import 'package:flareline_uikit/components/forms/outborder_text_form_field.dart';
import 'package:flareline_uikit/core/mvvm/bloc/bloc_base_stless_widget.dart';
import 'package:flareline_uikit/utils/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // Prevent back navigation
        body: ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return Center(
            child: contentDesktopWidget(context),
          );
        }

        return contentMobileWidget(context);
      },
    ));
  }

  Widget contentDesktopWidget(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
          width: 500,
          child: SvgPicture.asset('assets/signin/main.svg', semanticsLabel: ''),
        ),
        const SizedBox(
          width: 32,
        ),
        CommonCard(
          width: 430,
          child: _formWidget(context),
        )
      ]),
    ]);
  }

  Widget contentMobileWidget(BuildContext context) {
    return CommonCard(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: _formWidget(context),
    );
  }

  Widget _formWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: SignInForm(),
    );
  }
}

class SignInForm extends BlocBaseStlessWidget<SignInViewModel, SignInState> {
  SignInForm({super.key});

  @override
  Widget bodyWidget(
      BuildContext context, SignInViewModel viewModel, SignInState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'مرحبًا بعودتك',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'مرحبًا بك مرة أخرى! الرجاء إدخال تفاصيلك!',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(
          height: 16,
        ),
        OutBorderTextFormField(
          hintText: 'أدخل بريدك الإلكتروني',
          keyboardType: TextInputType.emailAddress,
          icon: Container(
            margin: const EdgeInsets.only(right: 8, left: 8),
            child: SvgPicture.asset(
              'assets/signin/email.svg',
              width: 20,
              height: 20,
            ),
          ),
          controller: viewModel.emailController,
        ),
        const SizedBox(
          height: 16,
        ),
        OutBorderTextFormField(
          obscureText: true,
          hintText: 'كلمة المرور',
          icon: Container(
            margin: const EdgeInsets.only(right: 8, left: 8),
            child: SvgPicture.asset(
              'assets/signin/lock.svg',
              width: 20,
              height: 20,
            ),
          ),
          controller: viewModel.passwordController,
        ),
        const SizedBox(
          height: 20,
        ),
        if (state.loginStatus != null)
          Text(
              (state.loginStatus ?? false)
                  ? 'تم تسجيل الدخول بنجاح'
                  : 'فشل تسجيل الدخول',
              style: TextStyle(
                color: (state.loginStatus ?? false)
                    ? CrmColors.green
                    : CrmColors.red,
              )),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          type: ButtonType.primary.type,
          btnText: 'تسجيل الدخول',
          onTap: () {
            viewModel.signIn();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('ليس لدي حساب؟'),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              child: const Text(
                'اشتراك',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/signUp');
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Expanded(
                child: Divider(
              height: 1,
              color: CrmColors.border,
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Text('أو'),
            ),
            const Expanded(
                child: Divider(
              height: 1,
              color: CrmColors.border,
            )),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
          color: Colors.white,
          borderColor: CrmColors.border,
          iconWidget: SvgPicture.asset(
            'assets/brand/brand-01.svg',
            width: 25,
            height: 25,
          ),
          btnText: 'تسجيل الدخول باستخدام جوجل',
          onTap: () {},
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  @override
  SignInViewModel viewModelBuilder(BuildContext context) {
    return SignInViewModel(context);
  }

  @override
  void blocListener(BuildContext context, SignInState state) {
    if (state.loginStatus != null && state.loginStatus!) {
      SnackBarUtil.showSnack(context, 'تم تسجيل الدخول بنجاح',
          color: Colors.green);
      Navigator.of(context).pushNamed('/day');
    }
  }
}
