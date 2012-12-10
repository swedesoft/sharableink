//
//  SWFormTemplateRepository.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWFormTemplate;

@interface SWFormTemplateRepository : NSObject

-(SWFormTemplate *)getTemplateByName:(NSString *)templateName;

@end
