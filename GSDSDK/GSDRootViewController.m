//
//  GSDRootViewController.m
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import "GSDRootViewController.h"
#import "GSDTabBar.h"
#import "GSDMasonry.h"
#import "GSDTabbarController.h"
#import "DemoViewController.h"
#import "GSDItemModel.h"
#import <objc/runtime.h>

@interface GSDRootViewController ()<GSDTabbarControllerDelegate>
{
    UIView* rootContainer;
    UIView* contentView;
    NSMutableArray* items;
    
    CGFloat MainMenuSize;
    CGFloat SecondMenuSize;
    GSDTabBarDirection mainDirection;
    GSDTabBarDirection secondDirection;
}
@property (nonatomic,strong) UIView* mainBarContainer;
@property (nonatomic,strong) UIView* secondBarContainer;

@end

@implementation GSDRootViewController

+(instancetype)shareInstanceWithTagString:(NSString *)tagString direction:(GSDRootViewControllerDirection)direction
{
    @synchronized(self) {
        static NSMutableDictionary* shareInstanceContainer;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            shareInstanceContainer = [NSMutableDictionary dictionary];
        });
        static id shareInstance;
        shareInstance = [shareInstanceContainer objectForKey:tagString];
        if ([shareInstance isKindOfClass:[self class]]) {
        }else{
            shareInstance = [[self alloc]init];
            ((GSDRootViewController*)shareInstance).direction = direction;
        }
        return shareInstance;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.secondTabsContainer = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor orangeColor];
    {
        items = [NSMutableArray array];
        GSDItemModel* m = nil;
        {
            m = [GSDItemModel new];
            m.title = @"论坛";
            if (self.direction == GSDTabBarDirectionHorizontalLeft||self.direction == GSDTabBarDirectionHorizontalRight) {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select"]);
            }else {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal_s"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select_s"]);
            }
            
            [items addObject:m];
            
            m = [GSDItemModel new];
            m.title = @"官网";
            if (self.direction == GSDTabBarDirectionHorizontalLeft||self.direction == GSDTabBarDirectionHorizontalRight) {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select"]);
            }else {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal_s"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select_s"]);
            }
            [items addObject:m];
            
            m = [GSDItemModel new];
            m.title = @"客服";
            if (self.direction == GSDTabBarDirectionHorizontalLeft||self.direction == GSDTabBarDirectionHorizontalRight) {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select"]);
            }else {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal_s"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select_s"]);
            }
            [items addObject:m];
            
            m = [GSDItemModel new];
            m.title = @"活动";
            if (self.direction == GSDTabBarDirectionHorizontalLeft||self.direction == GSDTabBarDirectionHorizontalRight) {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select"]);
            }else {
                m.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_normal_s"]);
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_popbtn_select_s"]);
            }
            [items addObject:m];
        }
    }

    // Do any additional setup after loading the view.
    {
        CGFloat top = 30;
        CGFloat bottom = 30;
        CGFloat left = 20;
        CGFloat right = 20;
        switch (self.direction) {
            case GSDTabBarDirectionHorizontalLeftMain:
            {
                top = 30;
                bottom = 30;
                left = 20;
                right = 20;
                break;
            }
            case GSDTabBarDirectionHorizontalRightMain:
            {
                top = 30;
                bottom = 30;
                left = 20;
                right = 20;
                break;
            }
            case GSDTabBarDirectionVerticalTopMain:
            {
                top = 20;
                bottom = 20;
                left = 30;
                right = 30;
                break;
            }
            case GSDTabBarDirectionVerticalBottomMain:
            {
                top = 20;
                bottom = 20;
                left = 30;
                right = 30;
                break;
            }
            default:
                break;
        }
        rootContainer = [[UIView alloc]init];
        rootContainer.layer.cornerRadius = 5;
        rootContainer.layer.masksToBounds = YES;
        [self.view addSubview:rootContainer];
        [rootContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(top, left, bottom, right));
        }];
    }
    
    {
        MainMenuSize = 40;
        SecondMenuSize = 60;
        self.mainBarContainer = [[UIView alloc]init];
        [rootContainer addSubview:self.mainBarContainer];
        self.secondBarContainer = [[UIView alloc]init];
        [rootContainer addSubview:self.secondBarContainer];
        contentView = [[UIView alloc]init];
        [rootContainer addSubview:contentView];
        
        switch (self.direction) {
            case GSDTabBarDirectionHorizontalLeftMain:
            {
                [self.mainBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.left.top.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(MainMenuSize);
                }];
                [self.secondBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.right.top.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(SecondMenuSize);
                }];
                [contentView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.left.equalTo(self.mainBarContainer.mas_right);
                    make.right.equalTo(self.secondBarContainer.mas_left);
                    make.top.bottom.mas_equalTo(0);
                }];
                break;
            }
            case GSDTabBarDirectionHorizontalRightMain:
            {
                [self.mainBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.right.top.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(MainMenuSize);
                }];
                [self.secondBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.left.top.bottom.mas_equalTo(0);
                    make.width.mas_equalTo(SecondMenuSize);
                }];
                [contentView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.right.equalTo(self.mainBarContainer.mas_left);
                    make.left.equalTo(self.secondBarContainer.mas_right);
                    make.top.bottom.mas_equalTo(0);
                }];
                break;
            }
            case GSDTabBarDirectionVerticalTopMain:
            {
                [self.mainBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.left.top.right.mas_equalTo(0);
                    make.height.mas_equalTo(MainMenuSize);
                }];
                [self.secondBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.left.bottom.right.mas_equalTo(0);
                    make.height.mas_equalTo(SecondMenuSize);
                }];
                [contentView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.top.equalTo(self.mainBarContainer.mas_bottom);
                    make.bottom.equalTo(self.secondBarContainer.mas_top);
                    make.left.right.mas_equalTo(0);
                }];
                break;
            }
            case GSDTabBarDirectionVerticalBottomMain:
            {
                [self.mainBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.left.bottom.right.mas_equalTo(0);
                    make.height.mas_equalTo(MainMenuSize);
                }];
                [self.secondBarContainer mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.left.top.right.mas_equalTo(0);
                    make.height.mas_equalTo(SecondMenuSize);
                }];
                [contentView mas_makeConstraints:^(GSDMASConstraintMaker *make) {
                    make.top.equalTo(self.secondBarContainer.mas_bottom);
                    make.bottom.equalTo(self.mainBarContainer.mas_top);
                    make.left.right.mas_equalTo(0);
                }];
                break;
            }
            default:
                break;
        }
    }
    
    {
        switch (self.direction) {
            case GSDTabBarDirectionHorizontalLeftMain:
            {
                mainDirection = GSDTabBarDirectionHorizontalLeft;
                secondDirection = GSDTabBarDirectionHorizontalRight;
                break;
            }
            case GSDTabBarDirectionHorizontalRightMain:
            {
                secondDirection = GSDTabBarDirectionHorizontalLeft;
                mainDirection = GSDTabBarDirectionHorizontalRight;
                break;
            }
            case GSDTabBarDirectionVerticalTopMain:
            {
                mainDirection = GSDTabBarDirectionVerticalTop;
                secondDirection = GSDTabBarDirectionVerticalBottom;
                break;
            }
            case GSDTabBarDirectionVerticalBottomMain:
            {
                secondDirection = GSDTabBarDirectionVerticalTop;
                mainDirection = GSDTabBarDirectionVerticalBottom;
                break;
            }
            default:
                break;
        }
        
        self.mainTab = [[GSDTabbarController alloc]initWithDirection:mainDirection isMainTabbar:YES withItems:items gsdDelegate:self];
        [self addChildViewController:self.mainTab];
        [contentView addSubview:self.mainTab.view];
        [self.mainTab.view mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.mainBarContainer addSubview:self.mainTab.innerBar];
        [self.mainTab.innerBar mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    
    
    rootContainer.backgroundColor = [UIColor clearColor];
    contentView.backgroundColor = [UIColor whiteColor];
    self.mainBarContainer.backgroundColor = [UIColor clearColor];
    self.secondBarContainer.backgroundColor = [UIColor clearColor];
}

#pragma mark - GSDTabbarControllerDelegate

-(void)GSDTabbarController:(GSDTabbarController *)controller changeSelctedIndex:(NSInteger)index
{
    if (self.mainTab && controller != self.mainTab) {
        return;
    }
    if (index >=0 ) {
        GSDTabbarController* c = [self.secondTabsContainer objectForKey:[NSString stringWithFormat:@"%ld",(long)index]];
        if (!c) {
            return;
        }
        for (UIView * view in self.secondBarContainer.subviews) {
            [view removeFromSuperview];
        }
        [self.secondBarContainer addSubview:c.innerBar];
        [c.innerBar mas_makeConstraints:^(GSDMASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
}

-(UIViewController*)GSDTabbarController:(GSDTabbarController *)controller viewControllerForIndex:(NSIndexPath *)indexPath
{
    NSLog(@"--:%ld --:%ld",(long)indexPath.section,(long)indexPath.row);
    //主菜单
    if (indexPath.section == -1) {
        NSInteger row = indexPath.row;
        GSDTabbarController* subTab = nil;
        if (row == 0) {
            items = [NSMutableArray array];
            GSDItemModel* m = nil;
            {
                m = [GSDItemModel new];
                m.title = @"首页";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_index_icon_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"论坛";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_discussion_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"活跃玩家";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_player_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_zhanghao_select"];
                [items addObject:m];
                
            }

        }else if (row == 1){
            items = [NSMutableArray array];
            GSDItemModel* m = nil;
            {
                m = [GSDItemModel new];
                m.title = @"热门";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_index_icon_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"攻略";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_discussion_normal"];
                [items addObject:m];
                
            }

        }else if (row == 2) {
            items = [NSMutableArray array];
            GSDItemModel* m = nil;
            {
                m = [GSDItemModel new];
                m.title = @"客服求助";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_index_icon_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"建议墙";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_discussion_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"我的问题";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_player_normal"];
                [items addObject:m];
            }

        }else if (row == 3) {
            items = [NSMutableArray array];
            GSDItemModel* m = nil;
            {
                m = [GSDItemModel new];
                m.title = @"积分活动";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_index_icon_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"精品推荐";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_discussion_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"礼包福利";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_tab_player_normal"];
                [items addObject:m];
                
                m = [GSDItemModel new];
                m.title = @"积分商城";
                m.image = nil;
                m.selectedImage = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_zhong"]);
                m.secondImage = [UIImage imageNamed:@"gsd_zhanghao_select"];
                [items addObject:m];
            }
        }
        subTab = [[GSDTabbarController alloc]initWithDirection:secondDirection isMainTabbar:NO withItems:items gsdDelegate:self];
        if (!subTab) {
            return nil;
        }
        [self.secondTabsContainer setObject:subTab forKey:[NSString stringWithFormat:@"%ld",(long)row]];
        return subTab;
    }else {
        NSInteger section = indexPath.section;
        NSInteger row = indexPath.row;
    }
    DemoViewController* vc = nil;
    UINavigationController* navi = nil;
    vc =[[DemoViewController alloc]init];
    vc.view.backgroundColor = [UIColor whiteColor];
    navi = [[UINavigationController alloc]initWithRootViewController:vc];
    return navi;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
