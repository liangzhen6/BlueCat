//
//  BLSettingViewController.m
//  BlueCat
//
//  Created by Tony on 2022/8/27.
//

#import "BLSettingViewController.h"
#import "BLActivityManager.h"
#import "NSData+ImageContentType.h"
#import "UIImage+GIF.h"
#import <PhotosUI/PhotosUI.h>
#import <Photos/Photos.h>
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@interface BLSettingViewController ()<PHPickerViewControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIImageView *captureView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *captureW;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *captureH;

@property (weak, nonatomic) IBOutlet UIImageView *zoomView;

@property (nonatomic, strong) NSData *captureImageData;
@property (nonatomic, strong) NSData *backImageData;

@property (nonatomic, assign) BOOL updatedBackImage;
@property (nonatomic, assign) BOOL updatedCaptureImage;

@end

@implementation BLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *backImageData = [BLTools getImageDataWithName:BLActivityManager.shareManager.setting.mainImage];
    UIImage *backImage = [UIImage sd_imageWithGIFData:backImageData];
    if (backImage) {
        self.backImageView.image = backImage;
    } else {
        self.backImageView.image = [BLTools getImageWithName:BLActivityManager.shareManager.setting.mainImage];
    }
    
    
    self.captureW.constant = BLActivityManager.shareManager.setting.captureW;
    self.captureH.constant = BLActivityManager.shareManager.setting.captureH;
    
    
    NSData *captureImageData = [BLTools getImageDataWithName:BLActivityManager.shareManager.setting.captureImage];
    UIImage *captureImage = [UIImage sd_imageWithGIFData:captureImageData];
    if (captureImage) {
        // gif
        self.captureView.image = captureImage;
    } else {
        self.captureView.image = [BLTools getImageWithName:BLActivityManager.shareManager.setting.captureImage];
    }
    
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragViewDidDrag:)];
    [self.zoomView addGestureRecognizer:pan];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    
    [self.captureView addGestureRecognizer:tap];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)btnAction:(UIButton *)sender {
    
    if (sender.tag == 1) {
        // 去相册选图
        [self showImageSelectVC:@"选择背景"];
    }
    
    
    if (sender.tag == 3) {
        // 设置好了
        if (self.updatedBackImage) {
            NSData *imageData = self.backImageData;
            NSString *name = @"mainImage";
            NSString *path = [kDocument stringByAppendingPathComponent:name];
            BOOL isOK = [imageData writeToFile:path atomically:YES];
            
            if (isOK) {
                BLActivityManager.shareManager.setting.mainImage = name;
            }
        }
        
        if (self.updatedCaptureImage) {
            NSData *imageData = self.captureImageData;
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
    
    [self showImageSelectVC:@"选择小球"];
    
}


- (void)showImageSelectVC:(NSString *)title {
    PHPickerFilter *filter = [PHPickerFilter anyFilterMatchingSubfilters:@[PHPickerFilter.imagesFilter]];
    
    PHPickerConfiguration *config = [[PHPickerConfiguration alloc] init];
    config.filter= filter;
    config.preferredAssetRepresentationMode = PHPickerConfigurationAssetRepresentationModeCurrent;
    
    PHPickerViewController *pickerVC = [[PHPickerViewController alloc] initWithConfiguration:config];
    pickerVC.title = title;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
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


#pragma mark --PHPickerViewControllerDelegate
- (void)picker:(PHPickerViewController *)picker didFinishPicking:(NSArray<PHPickerResult *> *)results {
    if (results && results.count) {
        PHPickerResult *result = [results firstObject];
        NSItemProvider *itemProvoider = result.itemProvider;
        
        NSString *itemTypeIdentifier = itemProvoider.registeredTypeIdentifiers.firstObject;
        NSString *typeIdentifier = UTTypeGIF.identifier;

        if ([itemTypeIdentifier isEqualToString:UTTypeGIF.identifier]) {
            [itemProvoider loadItemForTypeIdentifier:UTTypeGIF.identifier options:nil completionHandler:^(__kindof id<NSSecureCoding>  _Nullable item, NSError * _Null_unspecified error) {
                NSLog(@"777");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSData *imageData = [NSData dataWithContentsOfFile:[(NSURL *)item path]];
                    if ([picker.title isEqualToString:@"选择背景"]) {
                        UIImage *image = [UIImage sd_imageWithGIFData:imageData];
                        self.backImageView.image = image;
                        self.updatedBackImage = YES;
                        self.backImageData = imageData;
                    }
                    
                    if ([picker.title isEqualToString:@"选择小球"]) {
                        UIImage *image = [UIImage sd_imageWithGIFData:imageData];
                        self.captureView.image = image;
                        self.updatedCaptureImage = YES;
                        self.captureImageData = imageData;
                    }
                    
                    
                });
            }];
        } else {
            [itemProvoider loadObjectOfClass:[UIImage class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([object isKindOfClass:[UIImage class]]) {
                        NSData *imageData = UIImageJPEGRepresentation(object, 0.8);
                        if ([picker.title isEqualToString:@"选择背景"]) {
                            UIImage *image = (UIImage *)object;
                            self.backImageView.image = image;
                            self.updatedBackImage = YES;
                            self.backImageData = imageData;
                        }
                        
                        if ([picker.title isEqualToString:@"选择小球"]) {
                            UIImage *image = (UIImage *)object;
                            self.captureView.image = image;
                            self.updatedCaptureImage = YES;
                            self.captureImageData = imageData;
                        }
                        
                    }
                });
            }];
        }
        
    }
    
    // 选取完图片后跳转回原控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
