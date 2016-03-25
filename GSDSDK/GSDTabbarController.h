//
//  GSDTabbarController.h
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSDTabBar.h"

#define RESIZE_IMAGE(image) ([image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height/2, image.size.width/2, image.size.height/2, image.size.width/2) resizingMode:UIImageResizingModeStretch])

@class GSDTabbarController;

@protocol GSDTabbarControllerDelegate <NSObject>

-(void)GSDTabbarController:(GSDTabbarController*)controller changeSelctedIndex:(NSInteger)index;

-(UIViewController*)GSDTabbarController:(GSDTabbarController*)controller viewControllerForIndex:(NSIndexPath*)indexPath;

@end

@interface GSDTabbarController : UITabBarController

@property (nonatomic,strong) GSDTabBar* innerBar;

@property (nonatomic,assign) GSDTabBarDirection direction;

@property (nonatomic,assign) BOOL isMain;

-(instancetype)initWithDirection:(GSDTabBarDirection)direction isMainTabbar:(BOOL)isMain withItems:(NSArray*)items gsdDelegate:(id<GSDTabbarControllerDelegate>)gsdDelegate;

@end
