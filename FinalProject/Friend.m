//
//  Friend.m
//  FinalProject
//
//  Created by Benjamin Schoen on 11/29/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import "Friend.h"

@implementation Friend

- (instancetype) init: (NSString *) firstName
             lastName: (NSString*) lastName
               number: (NSString*) number
{
    self = [super init];
    if(self)
    {
        _firstName = firstName;
        _lastName = lastName;
        _number = number;
    }
    return self;
}

- (NSDictionary *) convertForPList
{
    NSDictionary *friend = [NSDictionary dictionaryWithObjectsAndKeys:
                               self.firstName, kFirstName,
                               self.lastName, kLastName,
                            self.number, kNumber, nil
                            ];
    
    return friend;
}

@end
