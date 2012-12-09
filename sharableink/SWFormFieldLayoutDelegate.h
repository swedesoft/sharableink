//
//  SWFormFieldLayoutDelegate.h
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SWFormFieldLayoutDelegate <UICollectionViewDelegate>

- (CGRect)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout locationForItemAtIndexPath:(NSIndexPath *)indexPath;



@end
