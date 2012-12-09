//
//  SWFormFieldLayout.m
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWFormFieldLayout.h"
#import "SWFormBackground.h"

@implementation SWFormFieldLayout

#pragma mark - Overrides

-(id)init
{
    self = [super init];
    
    if (self)
    {
        UINib *nib = [UINib nibWithNibName:@"FormBackground" bundle:nil];
        [self registerNib:nib forDecorationViewOfKind:@"Background"];
    }
    
    return self;
}





//shouldInvalidateLayoutForBoundsChange:

-(CGSize)collectionViewContentSize
{
    TFLog(@"Inside collectionViewContentSizze");
    float zoomScale = self.collectionView.zoomScale;
    return CGSizeMake(self.collectionView.frame.size.width * zoomScale , self.collectionView.frame.size.height * zoomScale);
    
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;

}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}




-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TFLog(@"Inside layoutAttributesForItemAtIndexPath");
    UICollectionViewLayoutAttributes *attr =  [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    float zoomScale = self.collectionView.zoomScale;
    
    attr.frame = CGRectMake(100 + (-zoomScale*100), 400, 200*zoomScale,100*zoomScale);

   attr.zIndex = 1;

    
    return attr;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    TFLog(@"Inside layoutAttributesForDecorationViewOfKind");
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    TFLog(@"Frame: %@", NSStringFromCGRect(self.collectionView.frame));
    
    float zoomScale = self.collectionView.zoomScale;
    
    attr.frame = CGRectMake(0, 0, self.collectionView.frame.size.width*zoomScale, self.collectionView.frame.size.height*zoomScale);
    
    
    return attr;
}



-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    TFLog(@"Inside layoutAttributesForElementsInRect");

    
    UICollectionViewLayoutAttributes *background = [self layoutAttributesForDecorationViewOfKind:@"Background" atIndexPath:nil];


    return @[ [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]], background];
}







@end
