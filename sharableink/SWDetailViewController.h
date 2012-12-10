//
//  SWDetailViewController.h
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWPatient;

@interface SWDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic)SWPatient *patient;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
