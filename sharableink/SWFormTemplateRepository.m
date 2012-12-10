//
//  SWFormTemplateRepository.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWFormTemplateRepository.h"
#import "SWFormTemplate.h"
#import "SWFormFieldTemplate.h"

static int BackgroundWidth  = 1275;
static int BackgroundHeight = 1743;

@interface SWFormTemplateRepository ()

@property(strong,nonatomic)NSMutableDictionary* templates;

@end

@implementation SWFormTemplateRepository

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        self.templates = [NSMutableDictionary dictionary];
        
        [self createTemplates];
    }
    
    return self;
}

// Currently it will only create the Anasthesia template
//
-(void)createTemplates
{
    SWFormTemplate *template = [[SWFormTemplate alloc] init];
    
    template.name = @"Anesthesia";
    
    //Create the field defs
    SWFormFieldTemplate *procedureTemplate = [[SWFormFieldTemplate alloc] init];
    procedureTemplate.fieldName = @"Procedure";
    procedureTemplate.fieldClass = @"SWSingleSelectListField";
    procedureTemplate.location = CGRectMake(0.279*BackgroundWidth, 0.118*BackgroundHeight, 0.683*BackgroundWidth, 0.022*BackgroundHeight);
    procedureTemplate.displayTitle = @"Select procedure";
    procedureTemplate.modalInEditMode = NO;
    procedureTemplate.list = @[@"Procedure 1", @"Procedure 2"];

    [template addFormFieldTemplate:procedureTemplate];
    

    SWFormFieldTemplate *surgeonsTemplate = [[SWFormFieldTemplate alloc] init];
    surgeonsTemplate.fieldName = @"Surgeon";
    surgeonsTemplate.fieldClass = @"SWSingleSelectListField";
    surgeonsTemplate.location = CGRectMake(0.279*BackgroundWidth, 0.152*BackgroundHeight, 0.333*BackgroundWidth, 0.009*BackgroundHeight);
    surgeonsTemplate.displayTitle = @"Select surgeon";
    surgeonsTemplate.modalInEditMode = NO;
    surgeonsTemplate.list = @[@"Dr Doom", @"Dr Evil"];
    
    [template addFormFieldTemplate:surgeonsTemplate];

    
    SWFormFieldTemplate *anesthesiaProvidersTemplate = [[SWFormFieldTemplate alloc] init];
    anesthesiaProvidersTemplate.fieldName = @"AnesthesiaProvider";
    anesthesiaProvidersTemplate.fieldClass = @"SWSingleSelectListField";
    anesthesiaProvidersTemplate.location = CGRectMake(0.622*BackgroundWidth, 0.151*BackgroundHeight, 0.337*BackgroundWidth, 0.01*BackgroundHeight);
    anesthesiaProvidersTemplate.displayTitle = @"Select provider";
    anesthesiaProvidersTemplate.modalInEditMode = NO;
    anesthesiaProvidersTemplate.list = @[@"Dr Phil", @"Dr Dre"];
    
    [template addFormFieldTemplate:anesthesiaProvidersTemplate];
    

    SWFormFieldTemplate *dateField = [[SWFormFieldTemplate alloc] init];
    dateField.fieldName = @"Date";
    dateField.fieldClass = @"SWDateField";
    dateField.location = CGRectMake(0.036*BackgroundWidth, 0.178*BackgroundHeight, 0.145*BackgroundWidth, 0.013*BackgroundHeight);
    dateField.displayTitle = @"Select Date";
    dateField.modalInEditMode = YES;
    
    [template addFormFieldTemplate:dateField];
    
    [self.templates setObject:template forKey:template.name];
    
}

-(SWFormTemplate *)getTemplateByName:(NSString *)templateName
{
    
    return self.templates[templateName];
}

@end
