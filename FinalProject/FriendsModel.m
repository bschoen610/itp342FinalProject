//
//  FriendsModel.m
//  FinalProject
//
//  Created by Benjamin Schoen on 11/29/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import "FriendsModel.h"


@interface FriendsModel()

@property(strong, nonatomic) NSMutableArray* friends;


@end

@implementation FriendsModel

- (instancetype) init
{
    self = [super init];
    if(self)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = paths[0];
        NSLog(@"docDir = %@", documentsDirectory);
        
        self.filepath = [documentsDirectory stringByAppendingPathComponent:@"friends.plist"];
        NSLog(@"filepath = %@", self.filepath);
        
        NSMutableArray *friends = [NSMutableArray arrayWithContentsOfFile:self.filepath];
        
        
        if(!friends)
        {
 
        }
        else
        {
            
            _friends = [[NSMutableArray alloc] init];
            
            for (NSDictionary* cardD in friends) {
                Friend *friend = [[Friend alloc] init:cardD[kFirstName] lastName:cardD[kLastName] number:cardD[kNumber]];
                [ _friends addObject: friend];
            }
            
        }
        
    }
    return self;
    
}

+ (instancetype) sharedModel
{
    static FriendsModel* _sharedModel = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return  _sharedModel;
}

// Accessing number of friend in model
- (NSUInteger) numberOfFriends
{
    return [self.friends count];
}

// Accessing a friend – sets currentIndex appropriately


// Inserting a friend
- (void) insertWithFirstName: (NSString *) firstName
                     lastName: (NSString *) lastName
                   number: (NSString *) number
{
    Friend* friend1 = [[Friend alloc] init:firstName lastName:lastName number:number];
    
    [_friends addObject:friend1];
    
    [self save];
}

- (Friend *) friendAtIndex: (NSUInteger) index
{
    
    if(self.friends.count == 0)
    {
        return NULL;
    }
    else
    {
        _currentIndex = (int)index;
        return [self.friends objectAtIndex:index];
    }
    
}


// Removing a friend
- (void) removeFriend
{
    [_friends removeLastObject];
    [self save];
}
- (void) removeFriendAtIndex: (NSUInteger) index
{
    //[_flashcards removeObjectAtIndex:index];
    if(index < [_friends count])
    {
        [_friends removeObjectAtIndex:index];
        [self save];
    }
}

- (void) save {
    NSMutableArray *friends = [[NSMutableArray alloc] init];
    
    for (Friend* friend in self.friends) {
        NSDictionary *cardD = [friend convertForPList];
        [friends addObject: cardD];
    }
    
    [friends writeToFile: self.filepath atomically:YES];
}

@end
