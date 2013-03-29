//
//  UITableView+BTIAdditions.h
//
//  Taken from http://pragprog.com/titles/cdirec/ios-recipes

#import <Foundation/Foundation.h>


@interface UITableView (BTIAdditions)

/*
 Provides the index path for the row that contains a particular cell subview.
 This method was taken from Matt Drance's book noted above.
 */
- (NSIndexPath *)indexPathForRowContainingViewBTI:(UIView *)view;

@end
