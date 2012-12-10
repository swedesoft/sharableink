//
//  SWDetailViewController.m
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWDetailViewController.h"
#import "SWFormFieldLayout.h"
#import "SWSingleSelectListField.h"
#import "SWField.h"
#import "SWFieldController.h"
#import "SWFormFieldLayoutDelegate.h"
#import "SWFormController.h"
#import "SWForm.h"
#import "SWDateField.h"
#import "SWPatient.h"

static NSString *EditFormSegueIdentifier = @"EditForm";
static NSString *AddFormSegueIdentifier = @"AddForm";



@interface SWDetailViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SWFormControllerDelegate>


@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@property (weak, nonatomic) IBOutlet UICollectionView *docView;
@property (weak, nonatomic) IBOutlet UIImageView *background;

- (void)configureView;

@end

@implementation SWDetailViewController

#pragma mark - Managing the detail item

- (void)setPatient:(SWPatient *)newPatient;
{
    if (_patient != newPatient) {
        _patient = newPatient;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.patient != nil)
    {
        self.background.image = [UIImage imageNamed:@"WoodBackground.png"];
        self.navigationItem.title = [NSString stringWithFormat:@"Forms for %@", self.patient.name];
        [self.docView reloadData];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UINavigationController *rootController = (UINavigationController *)segue.destinationViewController;
    
    SWFormController * controller = rootController.viewControllers[0];
    
    if (controller != nil)
    {
        controller.delegate = self;
    }
    
    if ([segue.identifier isEqualToString:EditFormSegueIdentifier])
    {
        NSArray *selectedItemsIndexPaths = [self.docView indexPathsForSelectedItems];
        
        NSIndexPath *selectedItemPath = selectedItemsIndexPaths[0];
        
        //We are only allowing one selection and since we are being called here
        //we know we have one selected item
        SWForm *selectedForm = self.patient.forms[selectedItemPath.row];
        
        controller.form = selectedForm;

    }
}
	
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - UICollectionViewDataSource

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Setup the visual
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];

    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Form"]];
    
    [cell.contentView addSubview:image];
    
    
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.patient.forms count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.navigationController performSegueWithIdentifier:@"EditDocument" sender:self];
//}

#pragma mark - SWFormControllerDelegate methods

-(void)formControllerDidCancel:(SWFormController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)formControllerDidSave:(SWFormController *)controller
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}



@end
