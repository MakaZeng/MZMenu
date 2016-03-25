//
//  UIViewController+GSDRunTime.h
//  GSDSDK
//
//  Created by maka.zeng on 16/3/24.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GSDTabbarController.h"

@interface UIViewController(GSDRunTime)

@property (nonatomic,strong) GSDTabbarController* gsdTabbar;
@property (nonatomic,strong) GSDTabbarController* gsdRootTabbar;

-(void)gsd_showOrHideRedPoint:(BOOL)isShow;

-(void)gsd_showSelfTabbarRedPointWithIndexs:(NSArray*)indexs;

@end
