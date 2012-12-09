//
//  SWFormController.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWFormFieldControllerDelegate.h"

@class SWFormController;
@class SWForm;

@protocol SWFormControllerDelegate <NSObject>

-(void)formControllerDidCancel:(SWFormController *)controller;

-(void)formControllerDidSave:(SWFormController *)controller;

@end

@interface SWFormController : UIViewController<SWFormFieldControllerDelegate>

@property(weak,nonatomic)id<SWFormControllerDelegate> delegate;
@property(strong,nonatomic)SWForm *form;

@end
