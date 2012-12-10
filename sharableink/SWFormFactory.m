//
//  SWFormFactory.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWFormFactory.h"
#import "SWFormTemplate.h"
#import "SWForm.h"
#import "SWFormFieldTemplate.h"
#import "SWField.h"

static NSString *const FieldNameKey = @"fieldName";
static NSString *const FieldValueKey = @"fieldValue";
static NSString *const FormFieldKey = @"fields";

@implementation SWFormFactory

-(SWForm *)createFormFromTemplate:(SWFormTemplate *)template andJSONData:(NSDictionary *)jsonData
{
    SWForm *form = [[SWForm alloc] init];
    form.displayTitle = template.name;
    

    
    [jsonData[FormFieldKey] enumerateObjectsUsingBlock:^(NSDictionary *field, NSUInteger idx, BOOL *stop) {
        
        SWFormFieldTemplate *fieldTemplate = template.formFieldTemplates[field[FieldNameKey]];
        
        SWField *newField = [[NSClassFromString(fieldTemplate.fieldClass) alloc] init];
        
        newField.value = field[FieldValueKey];
        newField.location = fieldTemplate.location;
        newField.displayTitle = fieldTemplate.displayTitle;
        newField.modalInEditMode = fieldTemplate.modalInEditMode;
        newField.list = fieldTemplate.list;
        
        [form addField:newField];
        
    }];
    

    return form;
}

@end
