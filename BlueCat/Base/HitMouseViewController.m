//
//  HitMouseViewController.m
//  BlueCat
//
//  Created by Tony on 2023/3/12.
//

#import "HitMouseViewController.h"
#import "HitMouseView.h"

@interface HitMouseViewController ()

@end

@implementation HitMouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}


- (void)setupUI {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;

    CGFloat spanx1 = (screenW - 132*3)/4;
    for (NSInteger i = 0; i < 3; i++) {
        HitMouseView *mouseView = [[HitMouseView alloc] initWithFrame:CGRectMake(spanx1 + i*(132+spanx1), 20, 150, 132)];
        [self.view addSubview:mouseView];
    }
    
    CGFloat spanx2 = (screenW - spanx1*2 - 132*2)/3;
    for (NSInteger i = 0; i < 2; i++) {
        HitMouseView *mouseView = [[HitMouseView alloc] initWithFrame:CGRectMake(spanx1 + spanx2 + i*(132+spanx2), 120, 150, 132)];
        [self.view addSubview:mouseView];
    }
    
    
    for (NSInteger i = 0; i < 3; i++) {
        HitMouseView *mouseView = [[HitMouseView alloc] initWithFrame:CGRectMake(spanx1 + i*(132+spanx1), 220, 150, 132)];
        [self.view addSubview:mouseView];
    }
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backVC)];
    tap.numberOfTouchesRequired = 2;
    [self.view addGestureRecognizer:tap];
    
}


- (void)backVC {
    [self dismissViewControllerAnimated:YES completion:nil];
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
