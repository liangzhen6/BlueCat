//
//  ViewController.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "ViewController.h"
#import "BLPlayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BLPlayViewController *playViewController = [[BLPlayViewController alloc] init];
        playViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self presentViewController:playViewController animated:YES completion:nil];
    });
    
}


@end
