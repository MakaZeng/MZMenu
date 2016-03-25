//
//  MASConstraint.h
//  Masonry
//
//  Created by Jonas Budelmann on 20/07/13.
//  Copyright (c) 2013 cloudling. All rights reserved.
//

#import "GSDMASViewAttribute.h"
#import "GSDMASConstraint.h"
#import "GSDMASLayoutConstraint.h"
#import "GSDMASUtilities.h"

/**
 *  A single constraint.
 *  Contains the attributes neccessary for creating a NSLayoutConstraint and adding it to the appropriate view
 */
@interface GSDMASViewConstraint : GSDMASConstraint <NSCopying>

/**
 *	First item/view and first attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) GSDMASViewAttribute *firstViewAttribute;

/**
 *	Second item/view and second attribute of the NSLayoutConstraint
 */
@property (nonatomic, strong, readonly) GSDMASViewAttribute *secondViewAttribute;

/**
 *	initialises the MASViewConstraint with the first part of the equation
 *
 *	@param	firstViewAttribute	view.mas_left, view.mas_width etc.
 *
 *	@return	a new view constraint
 */
- (id)initWithFirstViewAttribute:(GSDMASViewAttribute *)firstViewAttribute;

/**
 *  Returns all MASViewConstraints installed with this view as a first item.
 *
 *  @param  view  A view to retrieve constraints for.
 *
 *  @return An array of MASViewConstraints.
 */
+ (NSArray *)installedConstraintsForView:(MAS_VIEW *)view;

@end
