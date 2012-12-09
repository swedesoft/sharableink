//
//  SWDateField.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWDateField.h"

@implementation SWDateField

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.viewControllerIdentifier = @"DateFieldController";
    }
    
    return self;
}

@end
