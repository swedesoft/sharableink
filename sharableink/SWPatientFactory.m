//
//  SWPatientFactory.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWPatientFactory.h"
#import "SWPatient.h"
#import "SWFormTemplateRepository.h"
#import "SWFormTemplate.h"
#import "SWFormFactory.h"

static NSString *const PatientKeyName = @"name";
static NSString *const PatientKeyForms = @"forms";
static NSString *const PatientKeyFormTemplate = @"template";
static NSString *const PatientKeyFormFields = @"fields";


@implementation SWPatientFactory

-(SWPatient *)createPatientFromJSONData:(NSDictionary *)jsonData
{
    SWPatient *patient = [[SWPatient alloc] init];
    
    patient.name = jsonData[PatientKeyName];
    
    NSArray *forms = jsonData[PatientKeyForms];
    
    [forms enumerateObjectsUsingBlock:^(NSDictionary * form, NSUInteger idx, BOOL *stop) {
        
        SWFormTemplate *template = [self.templateRepository getTemplateByName:form[PatientKeyFormTemplate]];
        
        [patient addForm:[self.formFactory createFormFromTemplate:template andJSONData:form]];
        
       
    }];
    
    
    return patient;
}

@end
