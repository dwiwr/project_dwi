import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawal_desa_dwi/constants/const.dart';
import 'package:kawal_desa_dwi/ui/shared/shared_style.dart';
import 'package:kawal_desa_dwi/ui/shared/ui_helper.dart';
import 'package:kawal_desa_dwi/ui/views/sign_up_view.dart';
import 'package:kawal_desa_dwi/ui/widgets/button_widget.dart';
import 'package:kawal_desa_dwi/ui/widgets/text_field_widget.dart';
import 'package:kawal_desa_dwi/viewmodels/login_view_model.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: LoadingOverlay(
          isLoading: model.busy,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Center(
                  child:Column(
                    children: <Widget>[
                      verticalSpaceMedium,
                      Text("Workshop Kawal Desa", style: titleTextStyle,),
                      verticalSpaceSmall,
                      Image.asset(
                        'assets/logo.jpeg',
                        width: size.width*0.3,
                        height: size.width*0.3,
                      ),
                      verticalSpaceMedium,
                      TextFieldWidget(
                        hintText: 'E-Mail',
                        icon: Icons.email,
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        textFieldController: model.emailController,
                        colorIcon: color_main
                      ),
                      verticalSpaceSmall,
                      TextFieldWidget(
                        hintText: 'Password',
                        icon: Icons.lock,
                        keyboardType: TextInputType.emailAddress,
                        isPassword: true,
                        textFieldController: model.passwordController,
                      ),
                      verticalSpaceLarge,
                      ButtonWidget(
                        title: 'Login',
                        onPressedFunction: (){},
                        bgColor: color_main
                      ),
                      verticalSpaceMedium,
                      InkWell(
                        onTap: (){},
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: color_main,
                          ),
                        ),
                      ),
                      verticalSpaceMedium,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account? '),
                          InkWell(
                            onTap: (){
                              model.navigateToSignUpView();
                            },
                            child: Text('Sign Up',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                                color: color_main,
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpaceLarge,
                  ],
                ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}