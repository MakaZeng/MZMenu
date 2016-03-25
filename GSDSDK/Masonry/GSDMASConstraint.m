//
//  MASConstraint.m
//  Masonry
//
//  Created by Nick Tymchenko on 1/20/14.
//

#import "GSDMASConstraint.h"
#import "GSDMASConstraint+Private.h"

#define MASMethodNotImplemented() \
    @throw [NSException exceptionWithName:NSInternalInconsistencyException \
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
                                 userInfo:nil]

@implementation GSDMASConstraint

#pragma mark - Init

- (id)init {
	NSAssert(![self isMemberOfClass:[GSDMASConstraint class]], @"MASConstraint is an abstract class, you should not instantiate it directly.");
	return [super init];
}

#pragma mark - NSLayoutRelation proxies

- (GSDMASConstraint * (^)(id))equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (GSDMASConstraint * (^)(id))mas_equalTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationEqual);
    };
}

- (GSDMASConstraint * (^)(id))greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (GSDMASConstraint * (^)(id))mas_greaterThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationGreaterThanOrEqual);
    };
}

- (GSDMASConstraint * (^)(id))lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

- (GSDMASConstraint * (^)(id))mas_lessThanOrEqualTo {
    return ^id(id attribute) {
        return self.equalToWithRelation(attribute, NSLayoutRelationLessThanOrEqual);
    };
}

#pragma mark - MASLayoutPriority proxies

- (GSDMASConstraint * (^)())priorityLow {
    return ^id{
        self.priority(MASLayoutPriorityDefaultLow);
        return self;
    };
}

- (GSDMASConstraint * (^)())priorityMedium {
    return ^id{
        self.priority(MASLayoutPriorityDefaultMedium);
        return self;
    };
}

- (GSDMASConstraint * (^)())priorityHigh {
    return ^id{
        self.priority(MASLayoutPriorityDefaultHigh);
        return self;
    };
}

#pragma mark - NSLayoutConstraint constant proxies

- (GSDMASConstraint * (^)(MASEdgeInsets))insets {
    return ^id(MASEdgeInsets insets){
        self.insets = insets;
        return self;
    };
}

- (GSDMASConstraint * (^)(CGSize))sizeOffset {
    return ^id(CGSize offset) {
        self.sizeOffset = offset;
        return self;
    };
}

- (GSDMASConstraint * (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        self.centerOffset = offset;
        return self;
    };
}

- (GSDMASConstraint * (^)(CGFloat))offset {
    return ^id(CGFloat offset){
        self.offset = offset;
        return self;
    };
}

- (GSDMASConstraint * (^)(NSValue *value))valueOffset {
    return ^id(NSValue *offset) {
        NSAssert([offset isKindOfClass:NSValue.class], @"expected an NSValue offset, got: %@", offset);
        [self setLayoutConstantWithValue:offset];
        return self;
    };
}

- (GSDMASConstraint * (^)(id offset))mas_offset {
    // Will never be called due to macro
    return nil;
}

#pragma mark - NSLayoutConstraint constant setter

- (void)setLayoutConstantWithValue:(NSValue *)value {
    if ([value isKindOfClass:NSNumber.class]) {
        self.offset = [(NSNumber *)value doubleValue];
    } else if (strcmp(value.objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        self.centerOffset = point;
    } else if (strcmp(value.objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        self.sizeOffset = size;
    } else if (strcmp(value.objCType, @encode(MASEdgeInsets)) == 0) {
        MASEdgeInsets insets;
        [value getValue:&insets];
        self.insets = insets;
    } else {
        NSAssert(NO, @"attempting to set layout constant with unsupported value: %@", value);
    }
}

#pragma mark - Semantic properties

- (GSDMASConstraint *)with {
    return self;
}

- (GSDMASConstraint *)and {
    return self;
}

#pragma mark - Chaining

- (GSDMASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute __unused)layoutAttribute {
    MASMethodNotImplemented();
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

#pragma mark - Abstract

- (GSDMASConstraint * (^)(CGFloat multiplier))multipliedBy { MASMethodNotImplemented(); }

- (GSDMASConstraint * (^)(CGFloat divider))dividedBy { MASMethodNotImplemented(); }

- (GSDMASConstraint * (^)(MASLayoutPriority priority))priority { MASMethodNotImplemented(); }

- (GSDMASConstraint * (^)(id, NSLayoutRelation))equalToWithRelation { MASMethodNotImplemented(); }

- (GSDMASConstraint * (^)(id key))key { MASMethodNotImplemented(); }

- (void)setInsets:(MASEdgeInsets __unused)insets { MASMethodNotImplemented(); }

- (void)setSizeOffset:(CGSize __unused)sizeOffset { MASMethodNotImplemented(); }

- (void)setCenterOffset:(CGPoint __unused)centerOffset { MASMethodNotImplemented(); }

- (void)setOffset:(CGFloat __unused)offset { MASMethodNotImplemented(); }

#if TARGET_OS_MAC && !(TARGET_OS_IPHONE || TARGET_OS_TV)

- (MASConstraint *)animator { MASMethodNotImplemented(); }

#endif

- (void)activate { MASMethodNotImplemented(); }

- (void)deactivate { MASMethodNotImplemented(); }

- (void)install { MASMethodNotImplemented(); }

- (void)uninstall { MASMethodNotImplemented(); }

@end
