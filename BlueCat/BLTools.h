//
//  BLTools.h
//  BlueCat
//
//  Created by Tony on 2022/8/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface BLTools : NSObject

+ (nullable UIImage *)getImageWithName:(NSString *)name;

+ (nullable NSData *)getImageDataWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
