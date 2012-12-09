//
//  SWField.h
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWField : NSObject

@property(strong,nonatomic)NSString *viewControllerIdentifier;
@property(assign,nonatomic)CGRect location;
@property(strong, nonatomic)NSString *value;
@property(assign, nonatomic)BOOL modalInEditMode;
@property(strong, nonatomic)NSString *displayTitle;

@end
