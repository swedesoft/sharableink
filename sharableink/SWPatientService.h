//
//  SWPatientService.h
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

//This service is responsible for getting the patient data over the network to the
//device
@interface SWPatientService : NSObject

//Starts an asynchronous call to retrieve patients.
//Will fire the notification NotificationPatientsHasBeenRetrieved when data is back
-(void)requestPatients;

@end
