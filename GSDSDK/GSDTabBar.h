//
//  GSDTabBar.h
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    GSDTabBarDirectionHorizontalLeft,
    GSDTabBarDirectionHorizontalRight,
    GSDTabBarDirectionVerticalTop,
    GSDTabBarDirectionVerticalBottom,
} GSDTabBarDirection;


#define GSDTabBarTag 10086

@interface GSDTabBar : UIView

@property (nonatomic,strong) NSMutableArray* itemContainer;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,assign) GSDTabBarDirection direction;

@property (nonatomic,strong) NSArray* items;

@property (nonatomic,assign) BOOL isMain;

@property (nonatomic,assign) UIEdgeInsets paddingInset;

@property (nonatomic,assign) CGFloat itemInset;

@property (nonatomic,strong) UIImageView* backView;

-(instancetype)initWithItems:(NSArray*)items direction:(GSDTabBarDirection)direction isMainTabbar:(BOOL)isMain;

@end
