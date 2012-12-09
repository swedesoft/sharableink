//
//  SWFieldController.h
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWField.h"
#import "SWFormFieldControllerDelegate.h"



@protocol SWFieldController <NSObject>

@property(strong, nonatomic)SWField *field;
@property(weak, nonatomic)id<SWFormFieldControllerDelegate> formController;

@end
