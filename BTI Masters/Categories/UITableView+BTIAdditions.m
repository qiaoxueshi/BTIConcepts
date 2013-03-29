//
//  UITableView+BTIAdditions.h
//
//  Taken from http://pragprog.com/titles/cdirec/ios-recipes

#import "UITableView+BTIAdditions.h"

#import "BTIImport.h"

@implementation UITableView (BTIAdditions)

- (NSIndexPath *)indexPathForRowContainingViewBTI:(UIView *)view
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

	CGPoint correctedPoint = [view convertPoint:[view bounds].origin toView:self];

	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [self indexPathForRowAtPoint:correctedPoint];
}

@end
