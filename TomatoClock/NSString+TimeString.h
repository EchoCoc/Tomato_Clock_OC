//
//  NSString+TimeString.h
//  TomatoClock
//
//  Created by 章立彬 on 2021/1/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (TimeString)

+ (NSString *)getDefaultFormatTimeWithSecond:(NSInteger)second;

@end

NS_ASSUME_NONNULL_END
