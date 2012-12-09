//
//  SWSingleSelectLIstField.m
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWSingleSelectLIstField.h"

@implementation SWSingleSelectListField

-(id)init
{
    self = [super init];
    
    if (self)
    {
        self.viewControllerIdentifier = @"SingleSelectListController";
    }
    
    return self;
}

@end
