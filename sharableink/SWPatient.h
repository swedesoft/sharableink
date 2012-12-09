//
//  SWPatient.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWPatient : NSObject

@property(strong,nonatomic)NSString *name;
@property(strong,nonatomic)NSString *MRN;
@property(strong,nonatomic)NSString *accountNumber;

@property(strong,nonatomic)NSArray *forms;


@end
