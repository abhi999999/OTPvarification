import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: OtpPage(),
    );
  }
}

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String otp = '';
  final int numberOfOtpFields = 4;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isResent = false;

  void _onOtpEntered(String value) {
    setState(() {
      otp = value;
    });
  }

  void _onVerifyButtonPressed() {
    if (_formKey.currentState!.validate()) {
      if (otp.length == numberOfOtpFields) {
        print('Verifying OTP: $otp');
      } else {
        print('Incomplete OTP: $otp');
      }
    }
  }

  void _onResendButtonPressed() {
    print('Resending OTP...');

    setState(() {
      isResent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Verification code",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "We have send the code verification to",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade400),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: List.generate(
                    numberOfOtpFields,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 64,
                        width: 60,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                            }
                            _onOtpEntered(value);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            if (value.length != numberOfOtpFields) {
                              return 'Please enter a valid OTP';
                            }
                            return null;
                          },
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(fontSize: 24.0),
                          decoration: InputDecoration(
                            counterText: '',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _onVerifyButtonPressed,
                  child: Text('Verify'),
                ),
                SizedBox(height: 10.0),
                Visibility(
                  visible: !isResent,
                  child: TextButton(
                    onPressed: _onResendButtonPressed,
                    child: Text('Resend OTP'),
                  ),
                ),
                Visibility(
                  visible: isResent,
                  child: Text('OTP Resent!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
