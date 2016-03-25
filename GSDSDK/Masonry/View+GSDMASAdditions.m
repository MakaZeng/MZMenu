//
//  UIView+MASAdditions.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "View+GSDMASAdditions.h"
#import <objc/runtime.h>

@implementation MAS_VIEW (GSDMASAdditions)

- (NSArray *)mas_makeConstraints:(void(^)(GSDMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    GSDMASConstraintMaker *constraintMaker = [[GSDMASConstraintMaker alloc] initWithView:self];
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_updateConstraints:(void(^)(GSDMASConstraintMaker *))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    GSDMASConstraintMaker *constraintMaker = [[GSDMASConstraintMaker alloc] initWithView:self];
    constraintMaker.updateExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

- (NSArray *)mas_remakeConstraints:(void(^)(GSDMASConstraintMaker *make))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    GSDMASConstraintMaker *constraintMaker = [[GSDMASConstraintMaker alloc] initWithView:self];
    constraintMaker.removeExisting = YES;
    block(constraintMaker);
    return [constraintMaker install];
}

#pragma mark - NSLayoutAttribute properties

- (GSDMASViewAttribute *)mas_left {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeft];
}

- (GSDMASViewAttribute *)mas_top {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTop];
}

- (GSDMASViewAttribute *)mas_right {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRight];
}

- (GSDMASViewAttribute *)mas_bottom {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottom];
}

- (GSDMASViewAttribute *)mas_leading {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeading];
}

- (GSDMASViewAttribute *)mas_trailing {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailing];
}

- (GSDMASViewAttribute *)mas_width {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeWidth];
}

- (GSDMASViewAttribute *)mas_height {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeHeight];
}

- (GSDMASViewAttribute *)mas_centerX {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterX];
}

- (GSDMASViewAttribute *)mas_centerY {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterY];
}

- (GSDMASViewAttribute *)mas_baseline {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBaseline];
}

- (GSDMASViewAttribute *(^)(NSLayoutAttribute))mas_attribute
{
    return ^(NSLayoutAttribute attr) {
        return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:attr];
    };
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (GSDMASViewAttribute *)mas_leftMargin {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeftMargin];
}

- (GSDMASViewAttribute *)mas_rightMargin {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeRightMargin];
}

- (GSDMASViewAttribute *)mas_topMargin {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTopMargin];
}

- (GSDMASViewAttribute *)mas_bottomMargin {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeBottomMargin];
}

- (GSDMASViewAttribute *)mas_leadingMargin {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (GSDMASViewAttribute *)mas_trailingMargin {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (GSDMASViewAttribute *)mas_centerXWithinMargins {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (GSDMASViewAttribute *)mas_centerYWithinMargins {
    return [[GSDMASViewAttribute alloc] initWithView:self layoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif

#pragma mark - associated properties

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - heirachy

- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view {
    MAS_VIEW *closestCommonSuperview = nil;

    MAS_VIEW *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        MAS_VIEW *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}

@end
