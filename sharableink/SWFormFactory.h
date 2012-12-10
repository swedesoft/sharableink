//
//  SWFormFactory.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWFormTemplate;
@class SWForm;

@interface SWFormFactory : NSObject

-(SWForm *)createFormFromTemplate:(SWFormTemplate *)template andJSONData:(NSDictionary *)jsonData;

@end
