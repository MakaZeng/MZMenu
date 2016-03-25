//
//  GSDTabBar.m
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import "GSDTabBar.h"
#import "GSDMasonry.h"
#import "GSDTabBarItem.h"
#import "GSDItemModel.h"

@interface GSDTabBar ()

@end

@implementation GSDTabBar

-(instancetype)initWithItems:(NSArray *)items direction:(GSDTabBarDirection)direction isMainTabbar:(BOOL)isMain
{
    if (self = [self init]) {
        self.items = items;
        self.direction = direction;
        self.isMain = isMain;
        self.paddingInset = UIEdgeInsetsMake(10, 0, 10, 60);
        self.itemInset = 5;
        [self customLayout];
    }
    return self;
}

#define BUTTON_TAG 1000

-(void)customLayout
{
    self.backView = [[UIImageView alloc]init];
    self.backView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.backView];
    [self.backView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    GSDTabBarItem* tabbarItem = nil;
    NSInteger index = 0;
    if (self.items && self.items.count > 0) {
        for (GSDItemModel* item in self.items) {
            if (!self.itemContainer) {
                self.itemContainer = [NSMutableArray arrayWithCapacity:self.items.count];
            }
            
            BOOL isVertical = NO;
            if (self.direction == GSDTabBarDirectionVerticalTop || self.direction == GSDTabBarDirectionVerticalBottom) {
                isVertical = YES;
            }
            
            tabbarItem = [[GSDTabBarItem alloc]initWithIsMain:self.isMain isVertical:isVertical];
            tabbarItem.backgroundColor = [UIColor clearColor];
            [self addSubview:tabbarItem];
            
            {
                tabbarItem.normalImage = item.image;
                tabbarItem.selectedImage = item.selectedImage;
                tabbarItem.label.text = item.title;
                if (item.secondImage) {
                    tabbarItem.titleImageView.image = item.secondImage;
                    if (tabbarItem.label.text.length == 0) {
                        if (!self.isMain) {
                            [tabbarItem.titleImageView mas_remakeConstraints:^(GSDMASConstraintMaker *make) {
                                make.width.mas_equalTo(50);
                                make.height.mas_equalTo(50);
                                make.centerX.mas_equalTo(tabbarItem.mas_centerX);
                                make.centerY.mas_equalTo(tabbarItem.mas_centerY);
                            }];
                        }
                    }
                }
                tabbarItem.button.tag = BUTTON_TAG +index;
                [tabbarItem.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
                if (index == self.selectedIndex) {
                    tabbarItem.highLight = YES;
                }else {
                    tabbarItem.highLight = NO;
                }
                
                if (self.isMain) {
                    if (self.direction == GSDTabBarDirectionHorizontalLeft) {
                        tabbarItem.imageView.transform = CGAffineTransformMakeScale(-1, 1);
                    }else if (self.direction == GSDTabBarDirectionVerticalBottom) {
                        tabbarItem.imageView.transform = CGAffineTransformMakeScale(1, -1);
                    }

                }
                
            }
            
            GSDTabBarItem* lastTabbarItem = self.itemContainer.lastObject;
        
            [tabbarItem mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                if (self.isMain) {
                    switch (self.direction) {
                        case GSDTabBarDirectionHorizontalLeft:
                        {
                            make.right.mas_equalTo(0);
                            make.left.mas_equalTo(0);
                            if (lastTabbarItem) {
                                make.top.equalTo(lastTabbarItem.mas_bottom).with.offset(self.itemInset);
                                make.height.mas_equalTo(lastTabbarItem.mas_height);
                            }else {
                                make.top.mas_equalTo(0+self.paddingInset.top);
                            }
                            if (index == self.items.count-1) {
                                make.bottom.mas_equalTo(self.mas_bottom).with.offset(-self.paddingInset.bottom);
                            }
                            break;
                        }
                        case GSDTabBarDirectionHorizontalRight:
                        {
                            make.left.mas_equalTo(0);
                            make.right.mas_equalTo(0);
                            if (lastTabbarItem) {
                                make.top.equalTo(lastTabbarItem.mas_bottom).with.offset(self.itemInset);
                                make.height.mas_equalTo(lastTabbarItem.mas_height);
                            }else {
                                make.top.mas_equalTo(0+self.paddingInset.top);
                            }
                            if (index == self.items.count-1) {
                                make.bottom.mas_equalTo(self.mas_bottom).with.offset(-self.paddingInset.bottom);
                            }
                            break;
                        }
                        case GSDTabBarDirectionVerticalTop:
                        {
                            make.bottom.mas_equalTo(0);
                            make.top.mas_equalTo(0);
                            if (lastTabbarItem) {
                                make.left.equalTo(lastTabbarItem.mas_right).with.offset(self.itemInset);
                                make.width.mas_equalTo(lastTabbarItem.mas_width);
                            }else {
                                make.left.mas_equalTo(0+self.paddingInset.left);
                            }
                            if (index == self.items.count-1) {
                                make.right.mas_equalTo(self.mas_right).with.offset(-self.paddingInset.right);
                            }
                            break;
                        }
                        case GSDTabBarDirectionVerticalBottom:
                        {
                            make.top.mas_equalTo(0);
                            make.bottom.mas_equalTo(0);
                            if (lastTabbarItem) {
                                make.left.equalTo(lastTabbarItem.mas_right).with.offset(self.itemInset);
                                make.width.mas_equalTo(lastTabbarItem.mas_width);
                            }else {
                                make.left.mas_equalTo(0+self.paddingInset.left);
                            }
                            if (index == self.items.count-1) {
                                make.right.mas_equalTo(self.mas_right).with.offset(-self.paddingInset.right);
                            }
                            break;
                        }
                        default:
                            break;
                    }
                }else {
                    switch (self.direction) {
                        case GSDTabBarDirectionHorizontalLeft:
                        case GSDTabBarDirectionHorizontalRight:
                        {
                            make.left.right.mas_equalTo(0);
                            if (lastTabbarItem) {
                                make.top.equalTo(lastTabbarItem.mas_bottom);
                                make.height.mas_equalTo(lastTabbarItem.mas_height);
                            }else {
                                make.top.mas_equalTo(0);
                            }
                            if (index == self.items.count-1) {
                                make.bottom.mas_equalTo(0);
                            }
                            break;
                        }
                        case GSDTabBarDirectionVerticalTop:
                        case GSDTabBarDirectionVerticalBottom:
                        {
                            make.top.bottom.mas_equalTo(0);
                            if (lastTabbarItem) {
                                make.left.equalTo(lastTabbarItem.mas_right);
                                make.width.mas_equalTo(lastTabbarItem.mas_width);
                            }else {
                                make.left.mas_equalTo(0);
                            }
                            if (index == self.items.count-1) {
                                make.right.mas_equalTo(0);
                            }
                            break;
                        }
                        default:
                            break;
                    }
                }
            }];
            tabbarItem.tag = GSDTabBarTag+index;
            [self.itemContainer addObject:tabbarItem];
            index++;
        }
    }
}

-(void)buttonAction:(UIButton*)btn
{
    NSInteger index = btn.tag - BUTTON_TAG;
    self.selectedIndex = index;
}


-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex) {
        return;
    }
    GSDTabBarItem* item = self.itemContainer.count>selectedIndex?[self.itemContainer objectAtIndex:selectedIndex]:nil;
    if (item) {
        GSDTabBarItem* lastItem = [self.itemContainer objectAtIndex:self.selectedIndex];
//        [self willChangeValueForKey:@"selectedIndex"];
        _selectedIndex = selectedIndex;
//        [self didChangeValueForKey:@"selectedIndex"];
        lastItem.highLight = NO;
        item.highLight = YES;
    }
}

@end
