//
//  BTIObject.m
//
//  Created by Brian Slick in Feb 2013.
//  Copyright (c) 2013 BriTer Ideas LLC. All rights reserved.
//

#import "BTIObject.h"

#import <objc/runtime.h>
#import "BTIImport.h"

@interface BTIObject ()

// Private Properties
@property (nonatomic, assign, getter = isDescriptionInProgress) BOOL descriptionInProgress;

// Private Methods

@end

@implementation BTIObject

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization


#pragma mark - NSObject Overrides


#pragma mark - NSObject Protocol Methods

- (NSString *)description
{
	if ([self isDescriptionInProgress])
	{
		return [NSString stringWithFormat:@">>> Already logged: <%@: %p>", NSStringFromClass([self class]), self];
	}
	
	[self setDescriptionInProgress:YES];
	
	NSMutableString *description = [NSMutableString string];

	[description appendFormat:@"\n\n<%@: %p>\n", NSStringFromClass([self class]), self];
	[description appendString:@"{{\n"];
	
	// Get list of properties
	
	unsigned int outCount;
	objc_property_t *properties = class_copyPropertyList([self class], &outCount);
	
	// NOTE:
	// Commented code below was to workaround an issue where a child item might turn around and log this parent (self),
	// resulting in an infinite loop.  Problem appears to be worked around with the descriptionInProgress boolean, but
	// I'm leaving the code here just in case additional testing reveals a problem.
	
	for (int index = 0; index < outCount; index++)
	{
		objc_property_t property = properties[index];

		const char *propertyName = property_getName(property);
//		const char *propertyAttributes = property_getAttributes(property);
		
		NSString *propertyNameString = [NSString stringWithUTF8String:propertyName];
//		NSString *propertyAttributesString = [NSString stringWithUTF8String:propertyAttributes];
		
//		NSArray *attributeComponents = [propertyAttributesString componentsSeparatedByString:@","];
		
//		BOOL isWeak = [attributeComponents containsObject:@"W"];
		
		// Weak references might be a reference to a parent item that holds this object in a collection.
		// This will result in an infinite loop during building this string.  For lack of a better approach,
		// simply ignore weak references.
		
		id value = [self valueForKey:propertyNameString];
		
//		if (isWeak)
//		{
//			value = [NSString stringWithFormat:@"<Ignored Weak Reference> is nil: %@", (value == nil) ? @"YES" : @"NO"];
//		}
		
		[description appendFormat:@"     %@: %@\n", propertyNameString, value];
	}
	
	[description appendString:@"}}\n\n"];
	
	[self setDescriptionInProgress:NO];
	
	return description;
}

@end
