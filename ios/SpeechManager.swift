//
//  SpeechManager.swift
//  iosSpeechToText
//
//  Created by Antonio Nardi on 2/22/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation
import Speech

@objc(SpeechManager)

class SpeechManager: NSObject, SFSpeechRecognizerDelegate {
  
  private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "es-ES"))!
  
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  
  private var recognitionTask: SFSpeechRecognitionTask?
  
  private let audioEngine = AVAudioEngine()
  
  private var query: String?
  
   func microphoneTapped() {
    
    if audioEngine.isRunning {
      
      audioEngine.stop()
      recognitionRequest?.endAudio()
      
    } else {
      
      self.query = ""
      startRecording()
      
    }
    
    speechRecognizer.delegate = self
    
    SFSpeechRecognizer.requestAuthorization { (authStatus) in
      
      switch authStatus {
      case .authorized:
        print("User authorized access to speech recognition")
        
      case .denied:
        
        print("User denied access to speech recognition")
        
      case .restricted:
        print("Speech recognition restricted on this device")
        
      case .notDetermined:
        print("Speech recognition not yet authorized")
      }

    }

    
  }
  
  //Start Recording Function
  
  func startRecording() {
    
    
    if recognitionTask != nil {
      recognitionTask?.cancel()
      recognitionTask = nil
    }
    
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(AVAudioSessionCategoryRecord)
      try audioSession.setMode(AVAudioSessionModeMeasurement)
      try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
    } catch {
      print("AudioSession properties weren't set because of an error.")
    }
    
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    
    recognitionRequest?.shouldReportPartialResults = true
    
    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest!, resultHandler: { (result, error) in
 
      
      if result != nil {
        
        self.query = result?.bestTranscription.formattedString
        
      }

    })
    
    let recordingFormat = audioEngine.inputNode?.outputFormat(forBus: 0)
    audioEngine.inputNode?.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, time) in
      self.recognitionRequest?.append(buffer)
    }
    
    audioEngine.prepare()
    
    do {
      try audioEngine.start()
    } catch {
      print("AudioEngine couldn't start because of an error.")
    }
    
    
  }
  
  @objc func stopRecording(_ callback: (NSArray) -> () ) -> Void {
    
    audioEngine.stop();
    audioEngine.inputNode?.removeTap(onBus: 0)
    recognitionRequest?.endAudio()
    recognitionRequest = nil
    recognitionTask = nil
    
    if let query = query {
      
      if query != ""{
        
        let ret = [
          "result":query
        ]
        callback([ret])
        
      }
      
    }

    
  }
  
}
