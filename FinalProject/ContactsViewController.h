//
//  ContactsViewController.h
//  FinalProject
//
//  Created by Benjamin Schoen on 12/2/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts/Contacts.h"

@interface ContactsViewController : UIViewController

typedef void (^completionHandler)(NSString* firstName, NSString* lastName, NSString* number);

@property (copy, nonatomic) completionHandler handler;

@end
