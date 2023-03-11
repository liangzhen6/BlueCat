//
//  BLSettingViewController.m
//  BlueCat
//
//  Created by Tony on 2022/8/27.
//

#import "BLSettingViewController.h"
#import "BLActivityManager.h"

@interface BLSettingViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIImageView *captureView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *captureW;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *captureH;

@property (weak, nonatomic) IBOutlet UIImageView *zoomView;

@property (nonatomic, assign) BOOL updatedBackImage;
@property (nonatomic, assign) BOOL updatedCaptureImage;

@end

@implementation BLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView.image = [BLTools getImageWithName:BLActivityManager.shareManager.setting.mainImage];
    
    
    self.captureW.constant = BLActivityManager.shareManager.setting.captureW;
    self.captureH.constant = BLActivityManager.shareManager.setting.captureH;
    
    self.captureView.image = [BLTools getImageWithName:BLActivityManager.shareManager.setting.captureImage];
    
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewDidDrag:)];
    [self.zoomView addGestureRecognizer:pan];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    [self.captureView addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        // 去相册选图
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.title = @"选择背景";
        [self presentViewController:imagePickerController animated:YES completion:nil];
    }
    
    
    if (sender.tag == 3) {
        // 设置好了
        if (self.updatedBackImage) {
            NSData *imageData = UIImageJPEGRepresentation(self.backImageView.image, 0.8);
            NSString *name = @"mainImage";
            NSString *path = [kDocument stringByAppendingPathComponent:name];
            BOOL isOK = [imageData writeToFile:path atomically:YES];
            
            if (isOK) {
                BLActivityManager.shareManager.setting.mainImage = name;
            }
        }
        
        if (self.updatedCaptureImage) {
            NSData *imageData = UIImageJPEGRepresentation(self.captureView.image, 0.8);
            NSString *name = @"captureImage";
            NSString *path = [kDocument stringByAppendingPathComponent:name];
            BOOL isOK = [imageData writeToFile:path atomically:YES];
            
            if (isOK) {
                BLActivityManager.shareManager.setting.captureImage = name;
            }
        }
        
        BLActivityManager.shareManager.setting.captureW = self.captureW.constant;
        BLActivityManager.shareManager.setting.captureH = self.captureH.constant;

        
        [self dismissViewControllerAnimated:YES completion:nil];
    }

}

- (void)tapAction {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    imagePickerController.title = @"选择小球";
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}


- (void)dragViewDidDrag:(UIPanGestureRecognizer *)pan {
    CGPoint translation = [pan translationInView:self.view];
    
    CGFloat newW = self.captureW.constant + translation.x;
    CGFloat newH = self.captureH.constant + translation.y;
    
    if (newW > 20 && newH > 20) {
        self.captureW.constant = newW;
        self.captureH.constant = newH;
        
        [self.captureView layoutIfNeeded];
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
}




#pragma mark -UINavigationControllerDelegate,UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    if ([picker.title isEqualToString:@"选择背景"]) {
        self.backImageView.image = image;
        self.updatedBackImage = YES;
    }
    
    if ([picker.title isEqualToString:@"选择小球"]) {
        self.captureView.image = image;
        self.updatedCaptureImage = YES;
    }
    
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
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
