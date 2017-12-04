//
//  ContactsViewController.m
//  FinalProject
//
//  Created by Benjamin Schoen on 12/2/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import "ContactsViewController.h"
#import "Contacts/Contacts.h"
#import "ContactsUI/ContactsUI.h"


@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self selectContactData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectContactData {
    
    CNContactPickerViewController* picker = [[CNContactPickerViewController alloc] init];
    
    picker.delegate = self;
    picker.displayedPropertyKeys = (NSArray *)CNContactGivenNameKey;
    
    [self presentViewController:picker animated:NO completion:nil];
    
}

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSString *test = contact.givenName;
    NSLog(@"%@",test);
    
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
