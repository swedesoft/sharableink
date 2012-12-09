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

@interface SWDetailViewController () <UICollectionViewDataSource,SWFormFieldLayoutDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@property(strong,nonatomic)NSArray *fields;

@property (weak, nonatomic) IBOutlet UICollectionView *formsView;
@property(strong,nonatomic) NSIndexPath *currentSelectedPath;
@property(strong,nonatomic) UIPopoverController *fieldPopover;


@end

@implementation SWDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.formsView.collectionViewLayout = [[SWFormFieldLayout alloc] init];
    
    self.formsView.allowsSelection = YES;
    
    SWSingleSelectListField *field = [[SWSingleSelectListField alloc] init];
    
    field.list = @[@"Procedure 1", @"Procedure 2"];
    field.location = CGRectMake(200, 200, 400, 200);
    
    
    self.fields = @[field];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AnesthesiaRecord.png"]];
    
    return cell;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.fields count];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



#pragma mark -SWFormFieldLayoutDelegate

-(CGRect)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout locationForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SWField *field = self.fields[indexPath.row];
    
    return field.location;

}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return scrollView.subviews[0]; //Love the new literal capabilities like subscripting
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *selectedCell = [self.formsView cellForItemAtIndexPath:indexPath];
    
    SWField *selectedField = self.fields[indexPath.row];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:selectedField.viewControllerIdentifier];
    
    id<SWFieldController> fieldController = (id<SWFieldController>)controller;
    
    fieldController.field = selectedField;
    
    self.fieldPopover = [[UIPopoverController alloc] initWithContentViewController:controller];
    
    [self.fieldPopover presentPopoverFromRect:selectedCell.frame inView:self.formsView permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

#pragma mark - Private methods



- (void)viewDidUnload {
         [self setFormsView:nil];
         [super viewDidUnload];
}

@end
