//
//  UIViewController+MASAdditions.m
//  Masonry
//
//  Created by Craig Siemens on 2015-06-23.
//
//

#import "ViewController+GSDMASAdditions.h"

#ifdef MAS_VIEW_CONTROLLER

@implementation MAS_VIEW_CONTROLLER (MASAdditions)

- (GSDMASViewAttribute *)mas_topLayoutGuide {
    return [[GSDMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}
- (GSDMASViewAttribute *)mas_topLayoutGuideTop {
    return [[GSDMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (GSDMASViewAttribute *)mas_topLayoutGuideBottom {
    return [[GSDMASViewAttribute alloc] initWithView:self.view item:self.topLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}

- (GSDMASViewAttribute *)mas_bottomLayoutGuide {
    return [[GSDMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (GSDMASViewAttribute *)mas_bottomLayoutGuideTop {
    return [[GSDMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeTop];
}
- (GSDMASViewAttribute *)mas_bottomLayoutGuideBottom {
    return [[GSDMASViewAttribute alloc] initWithView:self.view item:self.bottomLayoutGuide layoutAttribute:NSLayoutAttributeBottom];
}



@end

#endif
