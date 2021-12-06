import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kawal_desa_dwi/ui/widgets/signups/form_image_data.dart';
import 'package:kawal_desa_dwi/ui/widgets/signups/form_location_data.dart';
import 'package:kawal_desa_dwi/ui/widgets/signups/form_personal_data.dart';
import 'package:kawal_desa_dwi/viewmodels/sign_up_view_model.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatefulWidget {

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State <SignUpView> {
  int _currentstep = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder:() => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: new Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
            onPressed: (){},
          ),
          elevation: 0,
          backgroundColor: Color(0xffFAFAFA),
          centerTitle: true,
        ),
        body: LoadingOverlay(
          isLoading: model.busy,
          child: new Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(primarySwatch: Colors.orange),
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: _currentstep,
                    controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue,
                      VoidCallback onStepCancel}) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: TextButton(
                              onPressed: onStepCancel,
                              child: const Text('BACK'),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: onStepContinue,
                              child: const Text('NEXT'),
                            ),
                          ),
                        ],
                      );
                    },
                    onStepTapped: (int step) =>
                        setState(() => _currentstep = step),
                    onStepContinue: _currentstep < 2
                        ? () => setState(() => _currentstep += 1)
                        : null,
                    onStepCancel: _currentstep > 0
                        ? () => setState(() => _currentstep -= 1)
                        : null,
                    steps: <Step>[
                      new Step(
                        title: new Text('Personal'),
                        content: FormPersonalData(model: model),
                        isActive: _currentstep >= 0,
                        state: _currentstep >= 0
                            ? StepState.complete
                            : StepState.disabled
                      ),
                      new Step(
                          title: new Text('Image'),
                          content: FormImageData(),
                          isActive: _currentstep >= 0,
                          state: _currentstep >= 1
                              ? StepState.complete
                              : StepState.disabled
                      ),                      new Step(
                          title: new Text('Location'),
                          content: FormLocationData(),
                          isActive: _currentstep >= 0,
                          state: _currentstep >= 2
                              ? StepState.complete
                              : StepState.disabled
                      ),
                    ],
                    ),
                  ),
                ), (_currentstep >= 2) ? Container(
                  child: ElevatedButton(
                    onPressed: (){},
                    child: Text('Sign Up'),
                  ),
                  width: size.width,
              ) : Container ()
            ],
          ),
        ),
      ),
    );
  }
}