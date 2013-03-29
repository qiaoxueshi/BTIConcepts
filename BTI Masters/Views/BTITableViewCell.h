//
//  BTITableViewCell.h
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This class overrides the reuseIdentifier to match the class name.  A class method is also provided to return that name.  This does work with XIB-based cells.  This avoids the issue of forgetting to specify the cell identifier in the XIB.  Naturally this will only work if all cells powered by this class should have the same reuse identifier.
 
 */

// Libraries
#import <UIKit/UIKit.h>

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BTITableViewCell : UITableViewCell
{
}

// IBOutlet Properties


// Other Public Properties


// IBActions


// Other Public Methods
+ (NSString *)reuseIdentifier;

@end
