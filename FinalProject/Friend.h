//
//  Friend.h
//  FinalProject
//
//  Created by Benjamin Schoen on 11/29/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import <Foundation/Foundation.h>

// constants
static NSString * const kFirstName = @"firstNameKey";
static NSString * const kLastName = @"lastNameKey";
static NSString * const kNumber = @"numberKey";

@interface Friend : NSObject

@property(strong, nonatomic, readonly) NSString* firstName;
@property(strong, nonatomic, readonly) NSString* lastName;
@property(strong, nonatomic, readonly) NSString* number;

- (instancetype) init: (NSString *) firstName
                           lastName: (NSString*) lastName
                       number: (NSString*) number;

- (NSDictionary *) convertForPList;


@end
