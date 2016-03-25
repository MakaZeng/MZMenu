//
//  DemoViewController.m
//  GSDSDK
//
//  Created by maka.zeng on 16/3/23.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import "DemoViewController.h"
#import "UIViewController+GSDRunTime.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)push:(id)sender {
    DemoViewController* demo = [[DemoViewController alloc]init];
    
    [self.navigationController pushViewController:demo animated:YES];
}

- (IBAction)present:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)show:(id)sender {
//    [self showOrHideRedPoint:YES];
    [self gsd_showSelfTabbarRedPointWithIndexs:@[@1,@2]];
}
- (IBAction)hide:(id)sender {
    [self gsd_showOrHideRedPoint:NO];
}
@end
