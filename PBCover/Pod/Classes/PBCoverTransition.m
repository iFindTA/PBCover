//
//  PBCoverTransition.m
//  PBCover
//
//  Created by nanhujiaju on 2017/9/8.
//  Copyright © 2017年 nanhujiaju. All rights reserved.
//

#import "PBCoverTransition.h"
//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND
//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS
#import <Masonry/Masonry.h>

static NSString * const PBCOVER_DEFAULT_ICON                       =   @"app_icon";
static NSString * const PBCOVER_PLACEHOLDER                        =   @"简单即是安安！";

@interface PBCoverTransition ()

@property (nonatomic, copy) PBCoverWillOver willCompletion;
@property (nonatomic, copy) PBCoverDidOver didCompletion;

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UILabel *placeView;

@property (nonatomic, strong)UIWindow *actionWindow;

@end

@implementation PBCoverTransition

#pragma mark == init factories ==

+ (instancetype)defaultCover {
    return [PBCoverTransition coverWithIcon:[UIImage imageNamed:PBCOVER_DEFAULT_ICON] withPlaceholder:PBCOVER_PLACEHOLDER];
}

+ (instancetype)coverWithIcon:(UIImage *)icon {
    icon = (icon == nil)? [UIImage imageNamed:PBCOVER_DEFAULT_ICON]:icon;
    return [PBCoverTransition coverWithIcon:icon withPlaceholder:PBCOVER_PLACEHOLDER];
}

+ (instancetype)coverWithIcon:(UIImage *)icon withPlaceholder:(NSString *)placeholder {
    icon = (icon == nil)? [UIImage imageNamed:PBCOVER_DEFAULT_ICON]:icon;
    placeholder = placeholder.length == 0?PBCOVER_PLACEHOLDER:placeholder;
    return [[PBCoverTransition alloc] initWithIcon:icon withPlaceholder:placeholder];
}

- (id)initWithIcon:(UIImage *)icon withPlaceholder:(NSString *)holder {
    self = [super init];
    if (self) {
        self.icon = icon;
        self.placeholder = holder.copy;
    }
    return self;
}

#pragma mark == custom UIs ==

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imgView];
    self.iconView = imgView;imgView.image = self.icon;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = self.placeholder;
    [self.view addSubview:label];
    self.placeView = label;
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    CGSize mainSize = bounds.size;
    
    __weak typeof(self) wkSlf = self;
    CGSize size = self.icon.size;
    if (size.width >= mainSize.width) {
        size = CGSizeMake(mainSize.width*0.6, (mainSize.width*size.height/size.width)*0.6);
    }
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(wkSlf) stgSlf = wkSlf;
        make.centerX.equalTo(stgSlf.view.mas_centerX);
        make.top.equalTo(stgSlf.view).offset(80*2);
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
    }];
    [self.placeView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(wkSlf) stgSlf = wkSlf;
        make.centerX.equalTo(stgSlf.view.mas_centerX);
        make.top.equalTo(stgSlf.iconView.mas_bottom).offset(50);
    }];
}

- (BOOL)prefersStatusBarHidden {
    return true;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (void)transitingCoverWithWillCompletion:(PBCoverWillOver)will didCompletion:(PBCoverDidOver)over {
    self.willCompletion = [will copy];
    self.didCompletion = [over copy];
    [self maskWillAppear];
}

- (void)maskWillAppear {
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    bounds.origin.y -= CGRectGetHeight(bounds);
    UIWindow *window = [[UIWindow alloc] initWithFrame:bounds];
    //    window.opaque = true;
    //    UIWindowLevel level = UIWindowLevelStatusBar+10.0f;
    //    if (_statusBarHiddenInited) {
    //        level = UIWindowLevelNormal+10.0f;
    //    }
    window.windowLevel = UIWindowLevelNormal;
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = self;
    [window makeKeyAndVisible];
    self.actionWindow = window;
    //动画淡入
    __weak typeof(self) wkSlf = self;
    //self.actionWindow.layer.opacity = 0.01f;
    bounds.origin.y += CGRectGetHeight(bounds);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        __strong typeof(wkSlf) stgSlf = wkSlf;
        //self.actionWindow.layer.opacity = 1.0f;
        stgSlf.actionWindow.frame = bounds;
    } completion:^(BOOL finished) {
        if (finished) {
            __strong typeof(wkSlf) stgSlf = wkSlf;
            [stgSlf dismiss];
        }
    }];
}

- (void)dismiss {
    
    if (self.willCompletion) {
        self.willCompletion();
    }
    CGRect bounds = [UIScreen mainScreen].bounds;
    bounds.origin.y -= CGRectGetHeight(bounds);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //self.actionWindow.layer.opacity = 0.01f;
        self.actionWindow.frame = bounds;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.actionWindow removeFromSuperview];
            [self.actionWindow resignKeyWindow];
            self.actionWindow = nil;
            if (self.didCompletion) {
                self.didCompletion(true);
            }
        }
    }];
}

@end
