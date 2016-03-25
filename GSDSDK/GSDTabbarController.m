//
//  GSDTabbarController.m
//  GSDSDK
//
//  Created by maka.zeng on 16/3/18.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import "GSDTabbarController.h"
#import "GSDMasonry.h"
#import "GSDItemModel.h"
#import "GSDRootViewController.h"
#import "UIViewController+GSDRunTime.h"

@interface GSDTabbarController ()

@property (nonatomic,strong) NSArray* items;

@property (nonatomic,weak) id<GSDTabbarControllerDelegate> gsdDelegate;

@end

@interface GSDPlaceHolderViewController: UIViewController

@end

@implementation GSDPlaceHolderViewController

@end


@implementation GSDTabbarController

-(instancetype)initWithDirection:(GSDTabBarDirection)direction isMainTabbar:(BOOL)isMain withItems:(NSArray *)items gsdDelegate:(id<GSDTabbarControllerDelegate>)gsdDelegate
{
    if (self  = [super init]) {
        self.tabBar.hidden = YES;
        self.direction = direction;
        self.isMain = isMain;
        self.items = items;
        self.gsdDelegate = gsdDelegate;
        {
            self.innerBar = [[GSDTabBar alloc]initWithItems:self.items direction:self.direction isMainTabbar:self.isMain];
            if (!self.isMain) {
                self.innerBar.backView.image = RESIZE_IMAGE([UIImage imageNamed:@"gsd_tab_bg"]);
            }
            if (self.innerBar) {
                [self.innerBar addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew context:nil];
            }
        }
        GSDPlaceHolderViewController* vc = nil;
        NSMutableArray* mArray = [NSMutableArray arrayWithCapacity:items.count];
        for (GSDItemModel* model in items) {
            vc = [[GSDPlaceHolderViewController alloc]init];
            vc.view.backgroundColor = [UIColor whiteColor];
            [mArray addObject:vc];
        }
        self.viewControllers = mArray;
        if (1) {
            [self.innerBar willChangeValueForKey:@"selectedIndex"];
            self.innerBar.selectedIndex = 0;
            [self.innerBar didChangeValueForKey:@"selectedIndex"];
        }
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)dealloc
{
    if (self.innerBar) {
        [self.innerBar removeObserver:self forKeyPath:@"selectedIndex"];
    }
}

static NSInteger cacheSection;

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"selectedIndex"]) {
        NSInteger newIndex = [[change valueForKey:NSKeyValueChangeNewKey] integerValue];
        if (self.viewControllers.count <=newIndex || newIndex < 0) {
            return;
        }
        UIViewController* vc = self.viewControllers[newIndex];
        if ([vc isKindOfClass:[GSDPlaceHolderViewController class]]) {
            if (self.gsdDelegate && [self.gsdDelegate respondsToSelector:@selector(GSDTabbarController:viewControllerForIndex:)]) {
                NSIndexPath* indexPath = nil;
                if (self.isMain) {
                    if (!self.gsdRootTabbar) {
                        cacheSection = newIndex;
                    }
                    indexPath = [NSIndexPath indexPathForRow:newIndex inSection:-1];
                }else {
                    ///-------------
                    NSInteger section = self.gsdRootTabbar.innerBar.selectedIndex;
                    if (!self.gsdRootTabbar) {
                        GSDRootViewController* v = [GSDRootViewController shareInstanceWithTagString:@"GSDRootViewController" direction:GSDTabBarDirectionHorizontalRightMain];
                        section = cacheSection;
                    }
                    indexPath = [NSIndexPath indexPathForRow:newIndex inSection:section];
                }
                vc = [self.gsdDelegate GSDTabbarController:self viewControllerForIndex:indexPath];
                if (vc) {
                    NSMutableArray* mArray = [self.viewControllers mutableCopy];
                    [mArray replaceObjectAtIndex:newIndex withObject:vc];
                    self.viewControllers = mArray;
                }
            }
        }
        self.selectedIndex = newIndex;
        if (self.gsdDelegate) {
            if ([self.gsdDelegate respondsToSelector:@selector(GSDTabbarController:changeSelctedIndex:)]) {
                [self.gsdDelegate GSDTabbarController:self changeSelctedIndex:self.selectedIndex];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
