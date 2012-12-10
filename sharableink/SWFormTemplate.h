//
//  SWFormTemplate.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWFormFieldTemplate;

//
// Represents a form and its field definitions (templates)
// 
@interface SWFormTemplate : NSObject

-(void)addFormFieldTemplate:(SWFormFieldTemplate *)formFieldTemplate;

@property(strong,nonatomic)NSDictionary *formFieldTemplates; //They are keyed by the FormFieldTemplate fieldName

@property(strong,nonatomic)NSString *name;

@end
