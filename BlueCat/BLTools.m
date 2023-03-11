//
//  BLTools.m
//  BlueCat
//
//  Created by Tony on 2022/8/27.
//

#import "BLTools.h"

@implementation BLTools

+ (nullable UIImage *)getImageWithName:(NSString *)name {
    UIImage *image = nil;
    
    image = [UIImage imageNamed:name];
    if (!image) {
        NSString *path = [kDocument stringByAppendingPathComponent:name];
        NSData *imageData = [NSData dataWithContentsOfFile:path];
        image = [UIImage imageWithData:imageData];
    }
    
    return image;
}

@end
