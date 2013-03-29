//
//  NSManagedObject+BTIAdditions.h
//
//  Created by Brian Slick in Aug 2012.
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (BTIAdditions)

/*
 Returns an NSEntityDescription for this NSManagedObject class such that entity name matches the class name.
 */
+ (NSEntityDescription *)entityDescriptionInContextBTI:(NSManagedObjectContext *)context;

/*
 Returns a new instance of this NSManagedObject class in the specified context.
 Uses entityDescriptionInContextBTI:, so the class name and entity name need to match.
 */
+ (instancetype)newManagedObjectInContextBTI:(NSManagedObjectContext *)context;

@end
