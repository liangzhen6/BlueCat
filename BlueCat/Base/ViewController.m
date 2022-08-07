//
//  ViewController.m
//  BlueCat
//
//  Created by Tony on 2022/7/30.
//

#import "ViewController.h"
#import "BLPlayViewController.h"
#import "BLActivityManager.h"
#import "BLActivitySetting.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *autoModeSwitch;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.autoModeSwitch.on = [BLActivityManager shareManager].setting.autoMode;
    // Do any additional setup after loading the view.
}
- (IBAction)switchAction:(UISwitch *)sender {
    [BLActivityManager shareManager].setting.autoMode = sender.isOn;
}

- (IBAction)settingAction:(UIButton *)sender {
    
    
}


- (IBAction)enterGameAction:(id)sender {
    [[BLActivityManager shareManager] buildMainPlayView];
    BLPlayViewController *playViewController = [[BLPlayViewController alloc] init];
    playViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:playViewController animated:YES completion:nil];
}

@end
