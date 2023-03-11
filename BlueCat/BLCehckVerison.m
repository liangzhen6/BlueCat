//
//  BLCehckVerison.m
//  BlueCat
//
//  Created by Tony on 2023/3/12.
//

#import "BLCehckVerison.h"
#import <UIKit/UIKit.h>
#import "SceneDelegate.h"

@implementation BLCehckVerison

+ (void)startCehckVersion {
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://github.com/liangzhen6/BlueCat/blob/main/BlueCat/check.json"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:kCFStringEncodingUTF8];
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
        if (![jsonStr containsString:currentVersion]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [BLCehckVerison showAlert];
            });
        }
    }] resume];
}

+ (void)showAlert {
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.baidu.com"] options:@{} completionHandler:nil];
    }];
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前版本较低，请升级到最新版本" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertVC addAction:okAction];
    
    NSArray *array =[[[UIApplication sharedApplication] connectedScenes] allObjects];
    UIWindowScene *windowScene = (UIWindowScene *)array[0];
    SceneDelegate *delegate =(SceneDelegate *)windowScene.delegate;

    [delegate.window.rootViewController presentViewController:alertVC animated:YES completion:nil];
}


@end
