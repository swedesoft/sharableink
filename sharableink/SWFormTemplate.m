//
//  SWFormTemplate.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWFormTemplate.h"
#import "SWFormFieldTemplate.h"

@interface SWFormTemplate ()

@property(strong,nonatomic)NSMutableDictionary *internalFields;

@end

@implementation SWFormTemplate

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.internalFields = [NSMutableDictionary dictionary];
    }
    
    return self;
}

-(void)addFormFieldTemplate:(SWFormFieldTemplate *)formFieldTemplate
{
    [self.internalFields setObject:formFieldTemplate forKey:formFieldTemplate.fieldName];
}

-(NSDictionary *)formFieldTemplates
{
    return self.internalFields;
}

@end
