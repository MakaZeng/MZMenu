//
//  GSDTabBarItem.h
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSDTabBarItem : UIView

@property (nonatomic,strong) UIImageView* imageView;

@property (nonatomic,strong) UIImageView* titleImageView;

@property (nonatomic,strong) UIImageView* redPointImageView;

@property (nonatomic,strong) UILabel* label;

@property (nonatomic,strong) UILabel* badgeLabel;

@property (nonatomic,strong) UIButton* button;

@property (nonatomic,strong) UIImage* normalImage;

@property (nonatomic,strong) UIImage* selectedImage;

@property (nonatomic,strong) UIImage* secondImage;

@property (nonatomic,assign) BOOL highLight;

@property (nonatomic,assign) BOOL isVertical;

-(instancetype)initWithIsMain:(BOOL)isMain isVertical:(BOOL)isVertical;

-(void)showOrHideRedPoint:(BOOL)isShow;

@end
