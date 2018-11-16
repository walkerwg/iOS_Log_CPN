//
//  LLog.h
//  Pods-iOS_Log_CPN_Example
//
//  Created by wangggang on 2018/11/16.
//

#import <Foundation/Foundation.h>
@import  CocoaLumberjack;

#ifdef DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#endif  /* DEBUG */

#define LLogVerbose(frmt, ...)  DDLogVerbose(frmt)                   // 详细日志
#define LLogDebug(frmt, ...)    DDLogDebug(frmt)                     // 调试日志
#define LLogInfo(frmt, ...)     DDLogInfo(frmt)                      // 信息日志
#define LLogWarn(frmt, ...)     DDLogWarn(frmt)                      // 警告日志
#define LLogError(frmt, ...)    DDLogError(frmt)                     // 错误日志

@interface LLog : NSObject

+ (void)ConfigLLog;

@end
