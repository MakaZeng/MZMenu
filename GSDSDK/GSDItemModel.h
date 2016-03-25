//
//  GSDItemModel.h
//  GSDSDK
//
//  Created by maka.zeng on 16/3/24.
//  Copyright © 2016年 maka.zeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface GSDItemModel : NSObject

@property (nonatomic,strong) UIImage* image;

@property (nonatomic,strong) UIImage* selectedImage;

@property (nonatomic,copy) NSString* title;

@property (nonatomic,copy) NSString* badgeString;

@property (nonatomic,strong) UIImage* secondImage;

@end
