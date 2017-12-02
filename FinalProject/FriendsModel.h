//
//  FriendsModel.h
//  FinalProject
//
//  Created by Benjamin Schoen on 11/29/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"



@interface FriendsModel : NSObject

@property (nonatomic, readonly) unsigned currentIndex;
@property (strong, nonatomic) NSString* filepath;



// Creating the model
+ (instancetype) sharedModel;

// Accessing number of friend in model
- (NSUInteger) numberOfFriends;

// Accessing a friend – sets currentIndex appropriately
- (Friend *) friendAtIndex: (NSUInteger) index;

// Inserting a friend

 - (void) insertWithFirstName: (NSString *) firstName
                     lastName: (NSString *) lastName
                   number: (NSString *) number;
 


// Removing a friend
- (void) removeFriend;
- (void) removeFriendAtIndex: (NSUInteger) index;

@end
