//
//  SWFormFieldCell.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWField.h"

@interface SWFormFieldCell : UIView

@property(strong,nonatomic)SWField *field;
@property(strong,nonatomic)NSString *label;

@end
