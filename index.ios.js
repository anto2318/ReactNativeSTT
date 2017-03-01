/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  NativeModules,
  Button,
  TouchableHighlight,
  Image
} from 'react-native';

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

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('iosSpeechToText', () => iosSpeechToText);
