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
    
    BLMainPlayView *mainView = [BLActivityManager shareManager].mainPlayView;
    [self.view addSubview:mainView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction)];
    tap.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}


- (void)backAction {
    [[BLActivityManager shareManager] dectoryMainPlayView];
    [self dismissViewControllerAnimated:NO completion:nil];
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
