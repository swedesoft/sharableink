//
//  SWFormFieldTemplate.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWFormFieldTemplate : NSObject

@property(strong,nonatomic)NSString *fieldClass;
@property(strong,nonatomic)NSString *fieldName;
@property(assign, nonatomic)CGRect location;
@property(assign,nonatomic)NSString *displayTitle;
@property(assign, nonatomic)BOOL modalInEditMode;
@property(strong,nonatomic)NSArray *list;


@end
