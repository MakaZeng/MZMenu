//
//  MASConstraintBuilder.m
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "GSDMASConstraintMaker.h"
#import "GSDMASViewConstraint.h"
#import "GSDMASCompositeConstraint.h"
#import "GSDMASConstraint+Private.h"
#import "GSDMASViewAttribute.h"
#import "View+GSDMASAdditions.h"

@interface GSDMASConstraintMaker () <MASConstraintDelegate>

@property (nonatomic, weak) MAS_VIEW *view;
@property (nonatomic, strong) NSMutableArray *constraints;

@end

@implementation GSDMASConstraintMaker

- (id)initWithView:(MAS_VIEW *)view {
    self = [super init];
    if (!self) return nil;
    
    self.view = view;
    self.constraints = NSMutableArray.new;
    
    return self;
}

- (NSArray *)install {
    if (self.removeExisting) {
        NSArray *installedConstraints = [GSDMASViewConstraint installedConstraintsForView:self.view];
        for (GSDMASConstraint *constraint in installedConstraints) {
            [constraint uninstall];
        }
    }
    NSArray *constraints = self.constraints.copy;
    for (GSDMASConstraint *constraint in constraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
    [self.constraints removeAllObjects];
    return constraints;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(GSDMASConstraint *)constraint shouldBeReplacedWithConstraint:(GSDMASConstraint *)replacementConstraint {
    NSUInteger index = [self.constraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.constraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (GSDMASConstraint *)constraint:(GSDMASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    GSDMASViewAttribute *viewAttribute = [[GSDMASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];
    GSDMASViewConstraint *newConstraint = [[GSDMASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];
    if ([constraint isKindOfClass:GSDMASViewConstraint.class]) {
        //replace with composite constraint
        NSArray *children = @[constraint, newConstraint];
        GSDMASCompositeConstraint *compositeConstraint = [[GSDMASCompositeConstraint alloc] initWithChildren:children];
        compositeConstraint.delegate = self;
        [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
        return compositeConstraint;
    }
    if (!constraint) {
        newConstraint.delegate = self;
        [self.constraints addObject:newConstraint];
    }
    return newConstraint;
}

- (GSDMASConstraint *)addConstraintWithAttributes:(MASAttribute)attrs {
    __unused MASAttribute anyAttribute = (MASAttributeLeft | MASAttributeRight | MASAttributeTop | MASAttributeBottom | MASAttributeLeading
                                          | MASAttributeTrailing | MASAttributeWidth | MASAttributeHeight | MASAttributeCenterX
                                          | MASAttributeCenterY | MASAttributeBaseline
#if TARGET_OS_IPHONE || TARGET_OS_TV
                                          | MASAttributeLeftMargin | MASAttributeRightMargin | MASAttributeTopMargin | MASAttributeBottomMargin
                                          | MASAttributeLeadingMargin | MASAttributeTrailingMargin | MASAttributeCenterXWithinMargins
                                          | MASAttributeCenterYWithinMargins
#endif
                                          );
    
    NSAssert((attrs & anyAttribute) != 0, @"You didn't pass any attribute to make.attributes(...)");
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    if (attrs & MASAttributeLeft) [attributes addObject:self.view.mas_left];
    if (attrs & MASAttributeRight) [attributes addObject:self.view.mas_right];
    if (attrs & MASAttributeTop) [attributes addObject:self.view.mas_top];
    if (attrs & MASAttributeBottom) [attributes addObject:self.view.mas_bottom];
    if (attrs & MASAttributeLeading) [attributes addObject:self.view.mas_leading];
    if (attrs & MASAttributeTrailing) [attributes addObject:self.view.mas_trailing];
    if (attrs & MASAttributeWidth) [attributes addObject:self.view.mas_width];
    if (attrs & MASAttributeHeight) [attributes addObject:self.view.mas_height];
    if (attrs & MASAttributeCenterX) [attributes addObject:self.view.mas_centerX];
    if (attrs & MASAttributeCenterY) [attributes addObject:self.view.mas_centerY];
    if (attrs & MASAttributeBaseline) [attributes addObject:self.view.mas_baseline];
    
#if TARGET_OS_IPHONE || TARGET_OS_TV
    
    if (attrs & MASAttributeLeftMargin) [attributes addObject:self.view.mas_leftMargin];
    if (attrs & MASAttributeRightMargin) [attributes addObject:self.view.mas_rightMargin];
    if (attrs & MASAttributeTopMargin) [attributes addObject:self.view.mas_topMargin];
    if (attrs & MASAttributeBottomMargin) [attributes addObject:self.view.mas_bottomMargin];
    if (attrs & MASAttributeLeadingMargin) [attributes addObject:self.view.mas_leadingMargin];
    if (attrs & MASAttributeTrailingMargin) [attributes addObject:self.view.mas_trailingMargin];
    if (attrs & MASAttributeCenterXWithinMargins) [attributes addObject:self.view.mas_centerXWithinMargins];
    if (attrs & MASAttributeCenterYWithinMargins) [attributes addObject:self.view.mas_centerYWithinMargins];
    
#endif
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:attributes.count];
    
    for (GSDMASViewAttribute *a in attributes) {
        [children addObject:[[GSDMASViewConstraint alloc] initWithFirstViewAttribute:a]];
    }
    
    GSDMASCompositeConstraint *constraint = [[GSDMASCompositeConstraint alloc] initWithChildren:children];
    constraint.delegate = self;
    [self.constraints addObject:constraint];
    return constraint;
}

#pragma mark - standard Attributes

- (GSDMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    return [self constraint:nil addConstraintWithLayoutAttribute:layoutAttribute];
}

- (GSDMASConstraint *)left {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeft];
}

- (GSDMASConstraint *)top {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTop];
}

- (GSDMASConstraint *)right {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRight];
}

- (GSDMASConstraint *)bottom {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottom];
}

- (GSDMASConstraint *)leading {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeading];
}

- (GSDMASConstraint *)trailing {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailing];
}

- (GSDMASConstraint *)width {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeWidth];
}

- (GSDMASConstraint *)height {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeHeight];
}

- (GSDMASConstraint *)centerX {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterX];
}

- (GSDMASConstraint *)centerY {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterY];
}

- (GSDMASConstraint *)baseline {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBaseline];
}

- (GSDMASConstraint *(^)(MASAttribute))attributes {
    return ^(MASAttribute attrs){
        return [self addConstraintWithAttributes:attrs];
    };
}

#if TARGET_OS_IPHONE || TARGET_OS_TV

- (GSDMASConstraint *)leftMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeftMargin];
}

- (GSDMASConstraint *)rightMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeRightMargin];
}

- (GSDMASConstraint *)topMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTopMargin];
}

- (GSDMASConstraint *)bottomMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeBottomMargin];
}

- (GSDMASConstraint *)leadingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeLeadingMargin];
}

- (GSDMASConstraint *)trailingMargin {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeTrailingMargin];
}

- (GSDMASConstraint *)centerXWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterXWithinMargins];
}

- (GSDMASConstraint *)centerYWithinMargins {
    return [self addConstraintWithLayoutAttribute:NSLayoutAttributeCenterYWithinMargins];
}

#endif


#pragma mark - composite Attributes

- (GSDMASConstraint *)edges {
    return [self addConstraintWithAttributes:MASAttributeTop | MASAttributeLeft | MASAttributeRight | MASAttributeBottom];
}

- (GSDMASConstraint *)size {
    return [self addConstraintWithAttributes:MASAttributeWidth | MASAttributeHeight];
}

- (GSDMASConstraint *)center {
    return [self addConstraintWithAttributes:MASAttributeCenterX | MASAttributeCenterY];
}

#pragma mark - grouping

- (GSDMASConstraint *(^)(dispatch_block_t group))group {
    return ^id(dispatch_block_t group) {
        NSInteger previousCount = self.constraints.count;
        group();

        NSArray *children = [self.constraints subarrayWithRange:NSMakeRange(previousCount, self.constraints.count - previousCount)];
        GSDMASCompositeConstraint *constraint = [[GSDMASCompositeConstraint alloc] initWithChildren:children];
        constraint.delegate = self;
        return constraint;
    };
}

@end
