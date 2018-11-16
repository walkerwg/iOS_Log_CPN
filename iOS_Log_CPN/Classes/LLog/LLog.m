//
//  LLog.m
//  Pods-iOS_Log_CPN_Example
//
//  Created by wangggang on 2018/11/16.
//

#import "LLog.h"
#import "LogFormatter.h"

@implementation LLog

+ (void)ConfigLLog {
    
    if ([UIDevice currentDevice].systemVersion.floatValue <= 10.0) {
        [DDOSLogger sharedInstance].logFormatter = [[LogFormatter alloc] init];
        [DDLog addLogger:[DDOSLogger sharedInstance] withLevel:ddLogLevel];
    } else {
        [DDTTYLogger sharedInstance].logFormatter = [[LogFormatter alloc] init];
        [DDLog addLogger:[DDTTYLogger sharedInstance] withLevel:ddLogLevel];
    }
    
    NSString *logDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"Logs"];
    DDLogFileManagerDefault * fileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logDirectory];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] initWithLogFileManager:fileManager];
    fileLogger.logFormatter = [[LogFormatter alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 刷新频率为24小时
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // 保存一周的日志，即7天
    [DDLog addLogger:fileLogger withLevel:ddLogLevel];
    DDLogVerbose(@"%@",fileLogger.currentLogFileInfo.filePath);
    
}

@end
