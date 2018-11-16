#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "LogFormatter.h"
#import "LLog.h"


FOUNDATION_EXPORT double iOS_Log_CPNVersionNumber;
FOUNDATION_EXPORT const unsigned char iOS_Log_CPNVersionString[];

