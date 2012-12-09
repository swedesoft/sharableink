//
//  SWForm.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWField;

@interface SWForm : NSObject

-(void)addField:(SWField *)field;

@property(strong,nonatomic,readonly)NSArray *formFields;
@property(strong,nonatomic)NSString *displayTitle;
@property(strong,nonatomic)NSString *createdOn;



@end
