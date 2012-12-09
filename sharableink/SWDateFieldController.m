//
//  SWDateFieldController.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWDateFieldController.h"
#import "SWDateField.h"

@interface SWDateFieldController ()


@property (weak, nonatomic) IBOutlet UIDatePicker *dateField;
- (IBAction)valueChanged:(id)sender;
@property(strong, nonatomic)NSDateFormatter *dateFormatter;

@end

@implementation SWDateFieldController

@synthesize field = _field;
@synthesize formController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
       
        
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [self.dateFormatter setDateFormat:@"MMMM d, yyyy"];
    
    return [super initWithCoder:aDecoder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupInitialDate];
    
    self.dateField.datePickerMode = UIDatePickerModeDate;
    
    if ( [self convertedField].modalInEditMode )
    {
        self.modalInPopover = YES;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneClicked:)];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelClicked:)];
    
        [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
        [self.navigationItem setRightBarButtonItem:doneButton animated:NO];
        
    }
}

-(void)doneClicked:(id)sender
{
    NSDate *editedDate = self.dateField.date;
    
    NSString *formattedDate = [self.dateFormatter stringFromDate:self.dateField.date];
    
    [self.formController field:self.field didEndEditingWithNewValue:formattedDate];
}

-(void)cancelClicked:(id)sender
{
    [self.formController didCancelEditingForField:self.field];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private methods

-(void)setupInitialDate
{
    NSDate *fieldDate = [self.dateFormatter dateFromString:self.field.value];
    
    if (fieldDate != nil)
    {
        self.dateField.date = [self.dateFormatter dateFromString:self.field.value];
    }
}

-(SWDateField *)convertedField
{
    return (SWDateField *)self.field;
}

@end
