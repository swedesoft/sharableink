//
//  SWFormFieldCell.m
//  sharableink
//
//  Created by PETER MOBERG on 12/9/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWFormFieldCell.h"

@interface SWFormFieldCell ()

@property(strong,nonatomic)UILabel *textLabel;

@end




@implementation SWFormFieldCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        self.textLabel.adjustsFontSizeToFitWidth = YES;
                [self addSubview:self.textLabel];
    }
    return self;
}

-(void)setLabel:(NSString *)label
{
    _label = label;
    self.textLabel.text = label;
    
}

-(void)setField:(SWField *)field
{
    _field = field;
    
    [field addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //No need to checkKeyPath since that is the only thing we have signed up for right now.
    NSString *newValue = change[NSKeyValueChangeNewKey];
    
    self.label = newValue;
    
}



@end
