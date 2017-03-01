# React Native Speech To Text
A Speech To Text library for React Native. Documentation [here](https://facebook.github.io/react-native/).

**Contribute to make this a universal module!** 

## Help Wanted
If you want to contribute with some small problems, here I leave you a list with some of them:

- Returns the result to the second time of pressing the start button
- An error occurs with "User authorized access to speech recognition": logDictationFailedWithError

It would be convenient to place a button with the events: PressIn (startSpeech) and PressOut (stopSpeech) of TouchableHighlight with a sound that indicates when it begins to recognize (AudioServicesPlaySystemSound)

# Example
Full example for iOS platform located in `/iosSpeechToText`.

# Usage

```javascript
var Voice = NativeModules.SpeechManager;

export default class iosSpeechToText extends Component {

  constructor(props){
    super(props);
    this.state = {
      word: ""
    }
  }
  
  startSpeech(){
    Voice.microphoneTapped();
  }

  stopSpeech(){
    var self = this;
    Voice.stopRecording(function(o) {

      if(o.result){
        self.setState({
          word: o.result
        })
      }else{
        alert("No result")
      }
    });
  }
  
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Start -> Speak -> Stop
        </Text>
        <Text style={styles.instructions}>
          {this.state.word}
        </Text>

          <Button title="start" style={{marginBottom:30}} onPress={this.startSpeech.bind(this)}></Button>
          <Button title="stop" onPress={this.stopSpeech.bind(this)}></Button>
      </View>
    );
  }
}
```

## Methods
Accessible methods to perform actions.

Method Name           | Description                                                                         | Platform
--------------------- | ----------------------------------------------------------------------------------- | --------
startSpeech()         | Starts listening for speech for a specific locale.                                  | iOS
stopSpeech()          | Stops listening for speech. Returns "No Result" if no data.                         | iOS


## Events
Methods that are invoked when a native event emitted.

Event Name                    | Description                                            | Event                                           | Platform
----------------------------- | ------------------------------------------------------ | ----------------------------------------------- | --------
SFSpeechRecognizer(event)     | Invoked when speech is recognized.                     | `{ error: false }`                              | iOS
recognitionTask(event)        | Recognizes speech from the audio source.               | `{ error: false }`                              | iOS
startRecording(event)         | Invoked when .start() is called without error.         | `{ error: false }`                              | iOS
stopRecording(event)          | Invoked when SpeechRecognizer stops recognition.       | `{ error: error as string }`                    | iOS
