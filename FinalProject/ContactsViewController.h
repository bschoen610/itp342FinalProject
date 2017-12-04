//
//  ContactsViewController.h
//  FinalProject
//
//  Created by Benjamin Schoen on 12/2/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts/Contacts.h"
#import <ContactsUI/CNContactPickerViewController.h>

@interface ContactsViewController : UIViewController <CNContactPickerDelegate>

typedef void (^completionHandler)(NSString* firstName, NSString* lastName, NSString* number);

@property (copy, nonatomic) completionHandler handler;

- (void) selectContactData;

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker;

@end
