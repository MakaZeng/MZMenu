//
//  GSDRootViewController.h
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSDTabbarController.h"

typedef enum : NSUInteger {
    GSDTabBarDirectionHorizontalLeftMain,
    GSDTabBarDirectionHorizontalRightMain,
    GSDTabBarDirectionVerticalTopMain,
    GSDTabBarDirectionVerticalBottomMain,
} GSDRootViewControllerDirection;

@interface GSDRootViewController : UIViewController

@property (nonatomic,strong) NSMutableDictionary* secondTabsContainer;

@property (nonatomic,assign) GSDRootViewControllerDirection direction;

@property (nonatomic,strong) GSDTabbarController* mainTab;

+(instancetype)shareInstanceWithTagString:(NSString*)tagString direction:(GSDRootViewControllerDirection)direction;

@end
