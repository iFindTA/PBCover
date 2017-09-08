//
//  PBCoverTransition.h
//  PBCover
//
//  Created by nanhujiaju on 2017/9/8.
//  Copyright © 2017年 nanhujiaju. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 block for will over
 */
typedef void(^PBCoverWillOver)(void);

/**
 block for did over
 */
typedef void(^PBCoverDidOver)(BOOL over);

@interface PBCoverTransition : UIViewController

/**
 generate default cover
 */
+ (instancetype)defaultCover;

/**
 generate cover with icon
 
 @param icon default was app's logo
 */
+ (instancetype)coverWithIcon:(UIImage *)icon;

/**
 generate cover with icon
 
 @param icon default was app's logo
 @param placeholder default was app's slogon
 */
+ (instancetype)coverWithIcon:(UIImage *)icon withPlaceholder:(NSString *)placeholder;

/**
 class method for transition with cover will finish/did finished
 
 @param will finish
 @param over did finished
 */
- (void)transitingCoverWithWillCompletion:(_Nullable PBCoverWillOver)will didCompletion:(_Nullable PBCoverDidOver)over;

@end

NS_ASSUME_NONNULL_END
