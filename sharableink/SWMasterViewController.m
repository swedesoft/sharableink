//
//  SWMasterViewController.m
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWMasterViewController.h"
#import "SWDetailViewController.h"
#import "SWPatient.h"


@interface SWMasterViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@property(strong,nonatomic)NSArray *patients;

@end

@implementation SWMasterViewController

- (void)awakeFromNib
{
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.detailViewController = (SWDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.patients = @[];
    
    //Need to clean this up when the view goes down
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePatientsHasBeenRetrieved:) name:NotificationPatientsHasBeenRetrieved object:nil];
    
    //Request to get some patients
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPatientsHasBeenRequested object:self];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.

}

#pragma mark - NSNotification handlers
-(void)handlePatientsHasBeenRetrieved:(NSNotification *)notification
{
    NSArray *patients = notification.userInfo[NotificationKeyPatients];
    
    self.patients = patients;
    
    [self.tableView reloadData];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.patients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.detailViewController.patient = self.patients[indexPath.row];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    SWPatient *selectedPatient = self.patients[indexPath.row];
    
    cell.textLabel.text = selectedPatient.name;
    
    
    
}

@end
