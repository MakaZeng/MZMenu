//
//  GSDTabBarItem.m
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import "GSDTabBarItem.h"
#import "GSDMasonry.h"

@interface GSDTabBarItem()

@property (nonatomic,strong) UIView* badgeContainerView;

@property (nonatomic,assign) BOOL isMain;

@end

@implementation GSDTabBarItem

-(instancetype)initWithIsMain:(BOOL)isMain isVertical:(BOOL)isVertical
{
    if (self = [super init]) {
        self.isMain = isMain;
        self.isVertical = isVertical;
        self.imageView = [[UIImageView alloc]init];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        if (!self.isMain) {
            self.titleImageView = [[UIImageView alloc]init];
            self.titleImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:self.titleImageView];
            [self.titleImageView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                make.width.mas_equalTo(35);
                make.height.mas_equalTo(35);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.centerY.mas_equalTo(self.mas_centerY).with.offset(-10);
            }];
        }
        
        self.label = [[UILabel alloc]init];
        self.label.textAlignment = NSTextAlignmentCenter;
        if (self.isMain) {
            self.label.font = [UIFont systemFontOfSize:14];
        }else {
            self.label.font = [UIFont systemFontOfSize:11];
        }
        
        self.label.numberOfLines = 0;
        self.label.backgroundColor = [UIColor clearColor];
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            if (!self.isMain) {
                make.top.mas_equalTo(self.titleImageView.mas_bottom);
            }else {
                make.top.mas_equalTo(5);
            }
            
            make.bottom.mas_equalTo(-5);
            if (self.isMain&&!self.isVertical) {
                make.width.mas_equalTo(18);
                make.centerX.mas_equalTo(self.mas_centerX);
            }else {
                make.left.mas_equalTo(5);
                make.right.mas_equalTo(-5);
            }
        }];
        
        self.badgeContainerView = [[UIView alloc]init];
        [self addSubview:self.badgeContainerView];
        self.badgeLabel = [[UILabel alloc]init];
        [self addSubview:self.badgeLabel];
        [self.badgeLabel mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            
        }];
        [self.badgeContainerView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            
        }];
        
        self.button = [[UIButton alloc]init];
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        
        if (!self.isMain)
        {
            self.redPointImageView = [[UIImageView alloc]init];
            self.redPointImageView.image = [UIImage imageNamed:@"gsd_new_msg"];
            [self addSubview:self.redPointImageView];
            self.redPointImageView.hidden=YES;
            [self.redPointImageView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                make.width.mas_equalTo(12);
                make.height.mas_equalTo(12);
                make.right.mas_equalTo(self.titleImageView.mas_right).with.offset(5);
                make.top.mas_equalTo(self.titleImageView.mas_top).with.offset(0);
            }];
        }
    }
    return self;
}

-(void)showOrHideRedPoint:(BOOL)isShow
{
    if (isShow) {
        self.redPointImageView.hidden = NO;
    }else {
        self.redPointImageView.hidden = YES;
    }
}

-(void)setHighLight:(BOOL)highLight
{
    _highLight = highLight;
    if (_highLight) {
        self.imageView.image = self.selectedImage;
        if (self.isMain) {
            self.label.textColor = [UIColor blueColor];
        }else {
            self.label.textColor = [UIColor whiteColor];
        }
    }else {
        self.imageView.image = self.normalImage;
        self.label.textColor = [UIColor whiteColor];
    }
    return;
}

@end
