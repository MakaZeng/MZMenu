//
//  UIViewController+MASAdditions.h
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "GSDMASUtilities.h"
#import "GSDMASConstraintMaker.h"
#import "GSDMASViewAttribute.h"

#ifdef MAS_VIEW_CONTROLLER

@interface MAS_VIEW_CONTROLLER (MASAdditions)

/**
 *	following properties return a new MASViewAttribute with appropriate UILayoutGuide and NSLayoutAttribute
 */
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_topLayoutGuide;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_bottomLayoutGuide;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_topLayoutGuideTop;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_topLayoutGuideBottom;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_bottomLayoutGuideTop;
@property (nonatomic, strong, readonly) GSDMASViewAttribute *mas_bottomLayoutGuideBottom;


@end

#endif
