//
//  SWPatientService.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWPatientService.h"
#import "AFNetworking.h"
#import "SWPatient.h"
#import "SWSingleSelectListField.h"
#import "SWField.h"
#import "SWForm.h"
#import "SWDateField.h"

static int BackgroundWidth  = 1275;
static int BackgroundHeight = 1743;



@implementation SWPatientService

-(id)init
{
    self = [super init];
    
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(patientsHasBeenRequested:) name:NotificationPatientsHasBeenRequested object:nil];
    }
    
    return self;
}

-(void)patientsHasBeenRequested:(NSNotification *)notification
{
    [self requestPatients];
}

-(void)requestPatients
{
//    NSURL *url = [NSURL URLWithString:@""];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSLog(@"Data came back");
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        NSLog(@"Something went wrong");
//    }];
//    
//    
//    [operation start];
    
    //Create some patients
    SWPatient *patient = [[SWPatient alloc] init];
    
    patient.name = @"Peter";
    patient.MRN = @"12345";
    patient.accountNumber = @"12345";
    
    patient.forms = @[[self createForm]];
    
    NSDictionary *userInfo = @{ NotificationKeyPatients : @[patient] };
    

    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationPatientsHasBeenRetrieved object:self userInfo:userInfo];

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

@end
