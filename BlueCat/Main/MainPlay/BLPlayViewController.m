//
//  BLPlayViewController.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "BLPlayViewController.h"
#import "BLActivityManager.h"
#import "BLMainPlayView.h"

@interface BLPlayViewController ()

@end

@implementation BLPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[BLActivityManager shareManager].mainPlayView];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
