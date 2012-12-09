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

static NSString *EditFormSegueIdentifier = @"EditForm";
static NSString *AddFormSegueIdentifier = @"AddForm";
static int BackgroundWidth  = 1275;
static int BackgroundHeight = 1743;



@interface SWDetailViewController () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SWFormControllerDelegate>

@property(strong,nonatomic)NSArray *forms;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@property (weak, nonatomic) IBOutlet UICollectionView *docView;

- (void)configureView;

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
    
    
    self.forms = @[[self createForm], [self createForm]];
    
}

-(SWForm *)createForm
{
    SWForm *form = [[SWForm alloc] init];
    form.displayTitle = @"Anast";
    
    SWSingleSelectListField *field = [[SWSingleSelectListField alloc] init];
    
    field.list = @[@"Procedure 1", @"Procedure 2"];
    CGSize imageSize = CGSizeMake(BackgroundWidth, BackgroundHeight);
    
    field.location = CGRectMake(0.279*imageSize.width, 0.118*imageSize.height, 0.683*imageSize.width, 0.022*imageSize.height);
    field.value = @"Procedure1";
    field.displayTitle = @"Select procedure";
    
    [form addField:field];
    
    
    SWSingleSelectListField *surgeonsField = [[SWSingleSelectListField alloc] init];
    
    surgeonsField.list = @[@"Dr 1", @"Dr 2"];
    surgeonsField.location = CGRectMake(0.279*imageSize.width, 0.152*imageSize.height, 0.333*imageSize.width, 0.009*imageSize.height);
    surgeonsField.value = @"Dr 1";
    surgeonsField.displayTitle = @"Select surgeon";
    
    [form addField:surgeonsField];
    
    SWSingleSelectListField *anesthesiaProvidersField = [[SWSingleSelectListField alloc] init];
    
    anesthesiaProvidersField.list = @[@"Dr 3", @"Dr 4"];
    anesthesiaProvidersField.location = CGRectMake(0.622*imageSize.width, 0.151*imageSize.height, 0.337*imageSize.width, 0.01*imageSize.height);
    anesthesiaProvidersField.value = @"Dr 3";
    anesthesiaProvidersField.displayTitle = @"Select provider";
    
    [form addField:anesthesiaProvidersField];
    
    SWDateField *dateField = [[SWDateField alloc] init];
    dateField.location = CGRectMake(0.036*imageSize.width, 0.178*imageSize.height, 0.145*imageSize.width, 0.013*imageSize.height);
    dateField.modalInEditMode = YES;
    dateField.displayTitle = @"Select date";
    
    [form addField:dateField];
    
    return form;
    
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
        SWForm *selectedForm = self.forms[selectedItemPath.row];
        
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
    
    CGRect labelFrame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
    
    [cell.contentView addSubview:label];
    
    //Setup the data
    SWForm *form = self.forms[indexPath.row];
    
    label.text = form.displayTitle;
    
    return cell;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.forms count];
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
