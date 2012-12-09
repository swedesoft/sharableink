//
//  SWFormControllerDelegate.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWField.h"

@protocol SWFormControllerDelegate <NSObject>

-(void)field:(SWField *)field didEndEditingWithNewValue:(NSString *)newValue;
-(void)didCancelEditingForField:(SWField *)field;

@end
