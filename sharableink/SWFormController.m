//
//  SWFormController.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWFormController.h"
#import "SWSingleSelectListField.h"
#import "SWField.h"
#import "SWFieldController.h"
#import "SWFormFieldLayoutDelegate.h"
#import "SWFormFieldCell.h"
#import "SWDateField.h"
#import "SWForm.h"

@interface SWFormController () <UIScrollViewDelegate,UIGestureRecognizerDelegate,UIPopoverControllerDelegate>



@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic)UIImageView *background;


@property(strong,nonatomic)UIPopoverController *fieldPopover;
@property(strong,nonatomic)UIViewController *currentPopoverContentController;
@property(strong,nonatomic)UIView *currentPopoverAnchor;

@end

@implementation SWFormController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    [self setupBackground];
    [self setupScrollView];
    [self layoutFormFields];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClicked:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonClicked:)];
    
    self.navigationController.title = @"Edit document";
    
    [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    [self.navigationItem setRightBarButtonItem:doneButton animated:NO];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    //Figure out what the minimum zoom scale should be so the background image
    //fits nicely into the scrollview.
    float xScale = self.scrollView.bounds.size.width / self.background.image.size.width;
    float yScale = self.scrollView.bounds.size.height / self.background.image.size.height;
    
    float minimumZoomScale = MAX(xScale,yScale);
    
    self.scrollView.minimumZoomScale = minimumZoomScale;
    self.scrollView.zoomScale = minimumZoomScale;
    
    //Animate the opacity of the scroll view here? 
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    if (self.fieldPopover)
    {
        [self.fieldPopover dismissPopoverAnimated:YES];
        self.fieldPopover = nil;
        
        [self presentPopoverWithController:self.currentPopoverContentController anchoredAt:self.currentPopoverAnchor];
    }
}

#pragma mark - Button handlers
-(void)doneButtonClicked:(id)sender
{
    [self.delegate formControllerDidCancel:self];
}

-(void)cancelButtonClicked:(id)sender
{
    [self.delegate formControllerDidSave:self];
}

#pragma mark - ScrollViewDelegate methods

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.background;
}

#pragma mark - UIPopoverControllerDelegate methods
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
}


#pragma mark - SWFormControllerDelegate

-(void)field:(SWField *)field didEndEditingWithNewValue:(NSString *)newValue
{
    [self teardownPopover];
    
    field.value = newValue;

}

-(void)didCancelEditingForField:(SWField *)field
{
    [self teardownPopover];
    
}

#pragma mark - Private methods

-(void)teardownPopover
{
    [self.fieldPopover dismissPopoverAnimated:YES];
    self.fieldPopover = nil;
    self.currentPopoverAnchor = nil;
    self.currentPopoverContentController = nil;
}

-(void)setupBackground
{
    self.background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AnesthesiaRecord.png"]];
    self.background.userInteractionEnabled = YES;

}

-(void)setupScrollView
{
    [self.scrollView addSubview:self.background];
    self.scrollView.contentSize = [self.background.image size];
    self.scrollView.maximumZoomScale = 1;


}
-(void)setupFormFields
{
        
    }

//Goes over all of the field meta data and creates form field cells and
//overlays them on the background
-(void)layoutFormFields
{

    [self.form.formFields enumerateObjectsUsingBlock:^(SWField * field, NSUInteger idx, BOOL *stop) {
        
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fieldWasSelected:)];
        recognizer.numberOfTapsRequired = 1;
        recognizer.delegate = self;
        
        SWFormFieldCell *cell = [[SWFormFieldCell alloc] initWithFrame:field.location];
        cell.label = field.value;
        
        
        cell.field = field;
        [cell addGestureRecognizer:recognizer];
        
        [self.background addSubview:cell];
    }];
}

//Called when a field has been tapped by the user. This method will
//launch the appropriate edit dialog
-(void)fieldWasSelected:(UIGestureRecognizer *)gestureRecognizer
{
    if (![gestureRecognizer.view isKindOfClass:[SWFormFieldCell class]])
    {
        return;
    }
    
    SWFormFieldCell *formFieldCell = (SWFormFieldCell *)gestureRecognizer.view;
    SWField *field = formFieldCell.field;
    
    UIViewController *controller = [self instantiateFieldControllerWithField:field];
    [self presentPopoverWithController:controller anchoredAt:formFieldCell];
    
}

-(void)presentPopoverWithController:(UIViewController *)controller anchoredAt:(UIView *)anchor
{

    
    self.fieldPopover = [[UIPopoverController alloc] initWithContentViewController:controller];
    self.currentPopoverAnchor = anchor;
    self.currentPopoverContentController = controller;
    
    [self.fieldPopover presentPopoverFromRect:anchor.frame inView:self.background permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    
}

-(UIViewController *)instantiateFieldControllerWithField:(SWField *)field
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Fields" bundle:nil];
    UIViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:field.viewControllerIdentifier];
    
    id<SWFieldController> fieldController = (id<SWFieldController>)controller;
    
    fieldController.field = field;
    fieldController.formController = self;
    
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    controller.navigationItem.title = field.displayTitle;
    
    
    return navController;
    
    
}


@end
