//
//  UIView+MASAdditions.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "GSDMASUtilities.h"
#import "GSDMASConstraintMaker.h"
#import "GSDMASViewAttribute.h"

/**
 *	Provides constraint maker block
 *  and convience methods for creating MASViewAttribute which are view + NSLayoutAttribute pairs
 */
@interface MAS_VIEW (GSDMASAdditions)

/**
 *	following properties return a new MASViewAttribute with current view and appropriate NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_left;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_top;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_right;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_bottom;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_leading;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_trailing;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_width;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_height;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_centerX;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_centerY;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_baseline;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *(^mas_attribute)(NSLayoutAttribute attr);

#if TARGET_OS_IPHONE || TARGET_OS_TV

@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_leftMargin;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_rightMargin;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_topMargin;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_bottomMargin;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_leadingMargin;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_trailingMargin;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_centerXWithinMargins;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_centerYWithinMargins;

#endif

/**
 *	a key to associate with this view
 */
@property (nonatomic, strong) id mas_key;

/**
 *	Finds the closest common superview between this view and another view
 *
 *	@param	view	other view
 *
 *	@return	returns nil if common superview could not be found
 */
- (instancetype)mas_closestCommonSuperview:(MAS_VIEW *)view;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created MASConstraints
 */
- (NSArray *)mas_makeConstraints:(void(^)(GSDMASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  If an existing constraint exists then it will be updated instead.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_updateConstraints:(void(^)(GSDMASConstraintMaker *make))block;

/**
 *  Creates a MASConstraintMaker with the callee view.
 *  Any constraints defined are added to the view or the appropriate superview once the block has finished executing.
 *  All constraints previously installed for the view will be removed.
 *
 *  @param block scope within which you can build up the constraints which you wish to apply to the view.
 *
 *  @return Array of created/updated MASConstraints
 */
- (NSArray *)mas_remakeConstraints:(void(^)(GSDMASConstraintMaker *make))block;

@end
