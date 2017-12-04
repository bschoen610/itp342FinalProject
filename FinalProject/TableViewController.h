//
//  TableViewController.h
//  FinalProject
//
//  Created by Benjamin Schoen on 11/28/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsModel.h"
#import "Contacts/Contacts.h"
#import "ContactsUI/ContactsUI.h"
#import <MessageUI/MessageUI.h>



@interface TableViewController : UITableViewController <CNContactPickerDelegate, MFMessageComposeViewControllerDelegate>

- (void) selectContactData;
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
