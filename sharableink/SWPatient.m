//
//  SWPatient.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWPatient.h"
#import "SWForm.h"

@interface SWPatient ()

@property(strong,nonatomic)NSMutableArray *internalForms;

@end

@implementation SWPatient

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.internalForms = [NSMutableArray array];
    }
    
    return self;
}


-(void)addForm:(SWForm *)form
{
    [self.internalForms addObject:form];
    
}

-(NSArray *)forms
{
    return self.internalForms;
}

@end
