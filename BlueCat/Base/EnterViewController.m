//
//  EnterViewController.m
//  BlueCat
//
//  Created by Tony on 2023/3/11.
//

#import "EnterViewController.h"
#import "ViewController.h"
#import <UMCommon/MobClick.h>

@interface EnterViewController ()

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.tag == 100) {
        // 足球
        [MobClick event:@"football"];
    }
    
    
    if (sender.tag == 101) {
        // 打地鼠
        [MobClick event:@"hitmouse"];
    }
    
    
    
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
