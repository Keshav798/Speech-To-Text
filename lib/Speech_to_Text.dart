import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;
import 'package:texttospeech/clear_button.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SpeechToText extends StatefulWidget {
  @override
  _SpeechToTextState createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  late speechToText.SpeechToText speech;
  String textString =
      ""; // for storing current values which are converted from text to speech
  String prev =
      ""; // for storing previous values(in case user doesn't press clear)
  bool isListen = false; //if app is listening

  void listen() async {
    prev = prev + " " + textString; //store curr string in prev(for future use)
    textString = ""; //set curr string to empty for new text
    bool avail = await speech.initialize(onError: (error) {
      Fluttertoast.showToast(msg: error.toString());
    }); //initializing speech to text
    if (avail) {
      //if initilization success
      setState(() {
        isListen = true;
      });
      speech.listen(onResult: (value) {
        //value stores the text of speech
        setState(() {
          textString = value.recognizedWords;
        });
      });
    }
  }

  void stop_listen() {
    setState(() {
      isListen = false;
      speech.stop();
    });
  }

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech To Text"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 200,
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Text(prev +
                    " " +
                    textString) // prev + textString means prev string before pause anmd current string
                ),
          ),
          Center(
              child: InkWell(
            onTap: () {
              //set entire string data to empt
              textString = "";
              prev = "";
              stop_listen(); //islogin set to false and stop listening
            },
            child: Clear_Button(),
          )),
          Center(
            child: Text(
              "Make sure you give microphone permissions in device settings.",
              style: TextStyle(fontSize: 9),
            ),
          )
        ],
      ),
      floatingActionButton: AvatarGlow(
        animate: isListen, //will only animate id isListen is true
        glowColor: Colors.red,
        endRadius: 65.0,
        duration: Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          child: Icon(isListen ? Icons.pause : Icons.mic),
          onPressed: () {
            if (isListen == false) {
              //if currently not listening so start listening
              listen();
            } else {
              //if currently listening
              stop_listen(); //islogin set to false and stop listening
            }
          },
        ),
      ),
    );
  }
}
