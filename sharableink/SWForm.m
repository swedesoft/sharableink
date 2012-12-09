//
//  SWForm.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWForm.h"

@interface SWForm ()

@property(strong,nonatomic,readwrite)NSMutableArray *internalFields;

@end

@implementation SWForm

-(id)init
{
    self = [super init];
    
    if (self != nil)
    {
        self.internalFields = [NSMutableArray array];
        
    }
    
    return self;
}

-(void)addField:(SWField *)field
{
    [self.internalFields addObject:field];
}

-(NSArray *)formFields
{
    return self.internalFields;
}



@end
