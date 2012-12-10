//
//  SWPatientFactory.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWFormTemplateRepository;
@class SWPatient;
@class SWFormFactory;

//
// This class is responsible for creating patients. It can create
// a patient object from raw json data
//
@interface SWPatientFactory : NSObject

@property(strong,nonatomic)SWFormTemplateRepository *templateRepository;
@property(strong,nonatomic)SWFormFactory *formFactory;


-(SWPatient *)createPatientFromJSONData:(NSDictionary *)jsonData;

@end
