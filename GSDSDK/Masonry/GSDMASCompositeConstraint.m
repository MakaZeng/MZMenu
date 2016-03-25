//
//  MASCompositeConstraint.m
//  Masonry
//
//  Created by Jonas Budelmann on 21/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "GSDMASCompositeConstraint.h"
#import "GSDMASConstraint+Private.h"

@interface GSDMASCompositeConstraint () <MASConstraintDelegate>

@property (nonatomic, strong) id mas_key;
@property (nonatomic, strong) NSMutableArray *childConstraints;

@end

@implementation GSDMASCompositeConstraint

- (id)initWithChildren:(NSArray *)children {
    self = [super init];
    if (!self) return nil;

    _childConstraints = [children mutableCopy];
    for (GSDMASConstraint *constraint in _childConstraints) {
        constraint.delegate = self;
    }

    return self;
}

#pragma mark - MASConstraintDelegate

- (void)constraint:(GSDMASConstraint *)constraint shouldBeReplacedWithConstraint:(GSDMASConstraint *)replacementConstraint {
    NSUInteger index = [self.childConstraints indexOfObject:constraint];
    NSAssert(index != NSNotFound, @"Could not find constraint %@", constraint);
    [self.childConstraints replaceObjectAtIndex:index withObject:replacementConstraint];
}

- (GSDMASConstraint *)constraint:(GSDMASConstraint __unused *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    id<MASConstraintDelegate> strongDelegate = self.delegate;
    GSDMASConstraint *newConstraint = [strongDelegate constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    newConstraint.delegate = self;
    [self.childConstraints addObject:newConstraint];
    return newConstraint;
}

#pragma mark - NSLayoutConstraint multiplier proxies 

- (GSDMASConstraint * (^)(CGFloat))multipliedBy {
    return ^id(CGFloat multiplier) {
        for (GSDMASConstraint *constraint in self.childConstraints) {
            constraint.multipliedBy(multiplier);
        }
        return self;
    };
}

- (GSDMASConstraint * (^)(CGFloat))dividedBy {
    return ^id(CGFloat divider) {
        for (GSDMASConstraint *constraint in self.childConstraints) {
            constraint.dividedBy(divider);
        }
        return self;
    };
}

#pragma mark - MASLayoutPriority proxy

- (GSDMASConstraint * (^)(MASLayoutPriority))priority {
    return ^id(MASLayoutPriority priority) {
        for (GSDMASConstraint *constraint in self.childConstraints) {
            constraint.priority(priority);
        }
        return self;
    };
}

#pragma mark - NSLayoutRelation proxy

- (GSDMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation {
    return ^id(id attr, NSLayoutRelation relation) {
        for (GSDMASConstraint *constraint in self.childConstraints.copy) {
            constraint.equalToWithRelation(attr, relation);
        }
        return self;
    };
}

#pragma mark - attribute chaining

- (GSDMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
    [self constraint:self addConstraintWithLayoutAttribute:layoutAttribute];
    return self;
}

#pragma mark - Animator proxy

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (MASConstraint *)animator {
    for (MASConstraint *constraint in self.childConstraints) {
        [constraint animator];
    }
    return self;
}

#endif

#pragma mark - debug helpers

- (GSDMASConstraint * (^)(id))key {
    return ^id(id key) {
        self.mas_key = key;
        int i = 0;
        for (GSDMASConstraint *constraint in self.childConstraints) {
            constraint.key([NSString stringWithFormat:@"%@[%d]", key, i++]);
        }
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant setters

- (void)setInsets:(MASEdgeInsets)insets {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        constraint.insets = insets;
    }
}

- (void)setOffset:(CGFloat)offset {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        constraint.offset = offset;
    }
}

- (void)setSizeOffset:(CGSize)sizeOffset {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        constraint.sizeOffset = sizeOffset;
    }
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        constraint.centerOffset = centerOffset;
    }
}

#pragma mark - MASConstraint

- (void)activate {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        [constraint activate];
    }
}

- (void)deactivate {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        [constraint deactivate];
    }
}

- (void)install {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        constraint.updateExisting = self.updateExisting;
        [constraint install];
    }
}

- (void)uninstall {
    for (GSDMASConstraint *constraint in self.childConstraints) {
        [constraint uninstall];
    }
}

@end
