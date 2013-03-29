//
//  BTINotificationHelper.h
//
//  Created by Brian Slick in Sept 2012.
//  Copyright (c) 2012 BriTer Ideas LLC. All rights reserved.
//

/*
 
OVERVIEW
 
 Notification handling can involve a fair amount of - duplication isn't the right word - repetition of code.
 Ex: to register:
 [[NSNotificationCenter defaultCenter] addObserver:whoever selector:@selector(theMethod) name:ATypicallyLongStringConstant object:whatever];
 To unregister:
 [[NSNotificationCenter defaultCenter] removeObserver:whoever name:ATypicallyLongStringConstant object:whatever];
 
 So it's not duplication in the sense of being copy-pasteable, but the elements of these methods are quite similar.  The combo of observer/name/object needs to be preserved in 2 places, which increases the opportunity for errors.
 
 This class attempts to remove that duplication.  A single helper is populated with observer/name/object one time, in one place, and can then be registered or unregistered easily, multiple times if necessary, by simply calling the appropriate method on that helper.
 
 This class is not intended to be standalone (though it can be used anywhere that notifications are), but instead used in concert with a view controller. The intention is to define ALL helpers in one place.  Since different notifications may have different life spans - for example, they should only repond when the view controller's view is visible, or they should respond during the entire lifetime of the view controller, the lifespan parameter is provided to enable this behavior, and also serve as documentation.  This avoids having to define some notifications in init, others in viewWillAppear, and then possibly having separate unregistration code in viewWillDisappear as well.  This reduces code, improves readability and discoverability, and makes the design intent of these notifications much clearer.
 
*/


// Libraries

// Classes and Forward Declarations
#import "BTIObject.h"

// Public Constants
typedef enum {
	BTINotificationRegistrationLifetime = 0,
	BTINotificationRegistrationVisible,
	BTINotificationRegistrationCustom,
} BTINotificationRegistrationLifeSpan;

@interface BTINotificationHelper : BTIObject
{
}

#pragma mark - Properties

/*
 Indicates how long the observer, typically a view controller, should listen for the designated notification.
 */
@property (nonatomic, assign, readonly) BTINotificationRegistrationLifeSpan lifeSpan;

#pragma mark - Methods

/*
 This is the standard initializer for this class.  No other means of initialization are supported.
 
 observer, selector, name, and object are all the same as what they would be for NSNotificationCenter's addObserver:selector:name:object: method. Specified values will be directly passed to that method, so refer to Apple documentation for specifics.
 
 lifeSpan is a constant (declared above) that defines when this notification should be registered. This class does not use this value directly.  It is up to other classes, specifically view controllers, to make use of the property.  The intention is that "Lifetime" would be registered for the life of the observing object, and that "Visible" would be registered only when that view controller's view is on screen.
 
 */
+ (instancetype)notificationHelperWithObserver:(id)observer
									  selector:(SEL)selector
										  name:(NSString *)name
										object:(id)object
									  lifeSpan:(BTINotificationRegistrationLifeSpan)lifeSpan;

/*
 Calling this method will add the corresponding observer/selector/name/object to NSNotificationCenter
 */
- (void)register;

/*
 Calling this method will remove the corresponding observer/name/object from NSNotificationCenter
 */
- (void)unregister;

@end
