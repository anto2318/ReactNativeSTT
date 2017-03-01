//
//  CalendarManagerBridge.m
//  SwiftBridge
//
//  Created by Michael Schwartz on 12/11/15.
//  Copyright © 2015 Facebook. All rights reserved.
//

// SpeechManagerBridge.m
#import <React/RCTBridgeModule.h>

@interface RCT_EXTERN_MODULE(SpeechManager, NSObject)

RCT_EXTERN_METHOD(microphoneTapped)
RCT_EXTERN_METHOD(stopRecording:(RCTResponseSenderBlock)callback);

@end
