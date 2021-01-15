//
//  NSString+TimeString.m
//  TomatoClock
//
//  Created by 章立彬 on 2021/1/15.
//

#import "NSString+TimeString.h"

@implementation NSString (TimeString)

+ (NSString *)getDefaultFormatTimeWithSecond:(NSInteger)second {
    NSLog(@"%ld", (long)second);
    NSAssert(second >= 0, @"ts error");
    NSInteger hour = second / 3600;
    NSInteger minute = (second - hour * 3600) / 60;
    NSInteger lastSecond = second - hour * 3600 - minute * 60;
    return [NSString stringWithFormat:@"%02ld : %02ld : %02ld", (long)hour, (long)minute, (long)lastSecond];
}

@end
