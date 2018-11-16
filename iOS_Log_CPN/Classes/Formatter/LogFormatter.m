//
//  LogFormatter.m
//  iOS_Log_CPN
//
//  Created by wangggang on 2018/11/16.
//

#import "LogFormatter.h"

@implementation LogFormatter
{
    int loggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;

}

- (NSString *)stringFromDate:(NSDate *)date {
    
    if (loggerCount <= 1) {
        // Single-threaded mode.
        
        if (threadUnsafeDateFormatter == nil) {
            threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
            [threadUnsafeDateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
        }
        
        return [threadUnsafeDateFormatter stringFromDate:date];
    } else {
        // Multi-threaded mode.
        // NSDateFormatter is NOT thread-safe.
        
        NSString *key = @"MyCustomFormatter_NSDateFormatter";
        
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
        
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss:SSS"];
            
            [threadDictionary setObject:dateFormatter forKey:key];
        }
        
        return [dateFormatter stringFromDate:date];
    }
}


- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *logLevel;
    switch (logMessage->_flag) {
        case DDLogFlagError    : logLevel = @"Error     "; break;
        case DDLogFlagWarning  : logLevel = @"Warning   "; break;
        case DDLogFlagInfo     : logLevel = @"Info      "; break;
        case DDLogFlagDebug    : logLevel = @"Debug     "; break;
        default                : logLevel = @"Default   "; break;
    }
    
    NSString *dateAndTime = [self stringFromDate:(logMessage->_timestamp)];
    NSString *logMsg = logMessage->_message;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0) {
        return [NSString stringWithFormat:@" %@ | %@",logLevel,logMsg];

    } else {
        return [NSString stringWithFormat:@"%@ %@ | %@",  dateAndTime,logLevel,logMsg];
    }
}

- (void)didAddToLogger:(id <DDLogger>)logger {
    loggerCount++;
    NSAssert(loggerCount <= 1, @"This logger isn't thread-safe");
}

- (void)willRemoveFromLogger:(id <DDLogger>)logger {
    loggerCount--;
}


@end
