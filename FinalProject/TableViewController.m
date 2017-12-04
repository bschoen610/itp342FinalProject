//
//  TableViewController.m
//  FinalProject
//
//  Created by Benjamin Schoen on 11/28/17.
//  Copyright © 2017 Benjamin Schoen. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) FriendsModel* model;

@property CNContactPickerViewController* picker;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton2;

@end

@implementation TableViewController
static NSString * const reuseIdentifier = @"reuse";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.model = [FriendsModel sharedModel];
    
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.model numberOfFriends];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Configure the cell...
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuse" forIndexPath:indexPath];
    
    NSString *tableCellText;
    
    Friend* friend1 = [self.model friendAtIndex:indexPath.row];
    tableCellText = [NSString stringWithFormat:@"%@", [friend1 firstName]];
    
    cell.textLabel.text = tableCellText;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [friend1 number]];
    
    return cell;
 
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.model removeFriendAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    
    //Clicking the add button brings you to the contacts
    [ self selectContactData];
}
-(void)selectContactData {
    
    //alloc and init a contact picker view controller
    _picker = [[CNContactPickerViewController alloc] init];
    
    _picker.delegate = self;
    _picker.displayedPropertyKeys =  @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    
    [self presentViewController:_picker animated:NO completion:nil];
    
    
}

-(void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    
    //This method is called when a contact is selected
    [self dismissViewControllerAnimated:NO completion:nil];
    
    //The only information i need from my contact is first name, last name, and number
    NSString *firstName = contact.givenName;
    NSString *lastName = contact.familyName;
    CNLabeledValue<CNPhoneNumber*> *number = (CNLabeledValue<CNPhoneNumber*>*)(contact.phoneNumbers[0]);
    NSLog(@"%@ %@ %@",firstName, lastName, number.value.stringValue);
    
    //insert into my model
    [self.model insertWithFirstName:firstName lastName:lastName number:number.value.stringValue];
    [self.tableView reloadData];
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     Friend* friend1 = [self.model friendAtIndex:indexPath.row];
     NSLog(@"%@ %@ %@",friend1.firstName, friend1.lastName, friend1.number);
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText])
    {
        //controller.body will be filled with information about my location
        NSString *textBody = [NSString stringWithFormat:@"I am at %@", self.model.myLocation];
        controller.body = textBody;
        //the only recipient is the selected contact
        controller.recipients = [NSArray arrayWithObjects:friend1.number, nil];
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    
    
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
