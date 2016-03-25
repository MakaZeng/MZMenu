//
//  UIViewController+GSDRunTime.m
//  GSDSDK
//
//  Created by maka.zeng on 16/3/24.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import "GSDTabBarItem.h"
#import <objc/runtime.h>
#import "UIViewController+GSDRunTime.h"

static const void *UIViewControllerGSDRunTimeRedPointImageView = &UIViewControllerGSDRunTimeRedPointImageView;
static const void *UIViewControllerGSDRunTimeGSDTabbarController = &UIViewControllerGSDRunTimeGSDTabbarController;
static const void *UIViewControllerGSDRunTimeGSDRootTabbarController = &UIViewControllerGSDRunTimeGSDRootTabbarController;

@implementation UIViewController(GSDRunTime)


-(void)setGsdTabbar:(GSDTabbarController *)gsdTabbar
{
    if (!gsdTabbar) {
        return;
    }
    objc_setAssociatedObject(self, UIViewControllerGSDRunTimeGSDTabbarController, gsdTabbar, OBJC_ASSOCIATION_ASSIGN);
}

-(GSDTabbarController*)gsdTabbar
{
    GSDTabbarController* gsdTabbar = objc_getAssociatedObject(self, UIViewControllerGSDRunTimeGSDTabbarController);
    if (gsdTabbar) {
        return gsdTabbar;
    }
    UIResponder* responder = self;
    NSInteger count = 0;
    while (responder) {
        count ++;
        if ([responder isKindOfClass:[GSDTabbarController class]]) {
            gsdTabbar = (id)responder;
            self.gsdTabbar = gsdTabbar;
        }else {
            responder = responder.nextResponder;
        }
        if (count > 20) {
            break;
        }
    }
    return gsdTabbar;
}

-(void)setGsdRootTabbar:(GSDTabbarController *)gsdRootTabbar
{
    if (!gsdRootTabbar) {
        return;
    }
    objc_setAssociatedObject(self, UIViewControllerGSDRunTimeGSDRootTabbarController, gsdRootTabbar, OBJC_ASSOCIATION_ASSIGN);
}

-(GSDTabbarController*)gsdRootTabbar
{
    GSDTabbarController* gsdRootTabbar = objc_getAssociatedObject(self, UIViewControllerGSDRunTimeGSDRootTabbarController);
    if (gsdRootTabbar) {
        return gsdRootTabbar;
    }
    UIResponder* responder = self;
    NSInteger count = 0;
    NSInteger index = 0;
    while (responder) {
        count ++;
        if ([responder isKindOfClass:[GSDTabbarController class]]) {
            index++;
            if (index >=2) {
                gsdRootTabbar = (id)responder;
                self.gsdRootTabbar = gsdRootTabbar;
                break;
            }
        }
        responder = responder.nextResponder;
        if (count > 20) {
            break;
        }
    }
    return gsdRootTabbar;
}

-(UIImageView*)redPointImageView
{
    UIImageView* imageView = nil;
    imageView =  objc_getAssociatedObject(self, UIViewControllerGSDRunTimeRedPointImageView);
    if ([imageView isKindOfClass:[UIView class]]) {
        return imageView;
    }
    
    GSDTabbarController* root = self.gsdTabbar;
    if (root) {
        GSDTabBar* innerBar = root.innerBar;
        if (innerBar) {
            NSInteger index = [root.viewControllers indexOfObject:self];
            if (!(index >=0 && index < root.viewControllers.count)) {
                index = [root.viewControllers indexOfObject:self.navigationController];
            }
            if (index >=0 && index < root.viewControllers.count) {
                index = [root.viewControllers indexOfObject:self.navigationController];
                GSDTabBarItem* item = [innerBar.itemContainer objectAtIndex:index];
                if (item) {
                    objc_setAssociatedObject(self, UIViewControllerGSDRunTimeRedPointImageView, item.redPointImageView, OBJC_ASSOCIATION_RETAIN);
                    return item.redPointImageView;
                }
            }
        }
    }
    
    return nil;
}

-(void)gsd_showOrHideRedPoint:(BOOL)isShow
{
    if (isShow) {
        self.redPointImageView.hidden = NO;
    }else {
        self.redPointImageView.hidden = YES;
    }
}

-(void)gsd_showSelfTabbarRedPointWithIndexs:(NSArray *)indexs
{
    GSDTabBar* tabbar = self.gsdTabbar.innerBar;
    if (tabbar) {
        NSInteger index = 0;
        for (GSDTabBarItem* item in tabbar.itemContainer) {
            [item showOrHideRedPoint:NO];
            for (NSNumber* n in indexs) {
                if (n.integerValue == index) {
                    [item showOrHideRedPoint:YES];
                }
            }
            index++;
        }
    }
}

@end
