//
//  SWFormFieldLayout.m
//  sharableink
//
//  Created by PETER MOBERG on 12/8/12.
//  Copyright (c) 2012 Swedesoft. All rights reserved.
//

#import "SWFormFieldLayout.h"
#import "SWFormBackground.h"
#import "SWFormFieldLayoutDelegate.h"

@implementation SWFormFieldLayout

#pragma mark - Overrides

-(id)init
{
    self = [super init];
    
    if (self)
    {
        //When the DecorationView "Background" is requested then the top-level
        //view in the following xib file is loaded. This will load the background
        //image representing the form.
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
    
    if (zoomScale < 1)
    {
        zoomScale = 1;
    }
    
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



// Returns the layoutAttributes instance for a particular 
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id<SWFormFieldLayoutDelegate> delegate = (id<SWFormFieldLayoutDelegate>)self.collectionView.delegate;
    
    CGRect location = [delegate collectionView:self.collectionView layout:self locationForItemAtIndexPath:indexPath];
    

    UICollectionViewLayoutAttributes *attr =  [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    float zoomScale = self.collectionView.zoomScale;
    
    if (zoomScale < 1)
    {
        zoomScale = 1;
    }
    
    attr.frame = CGRectMake(location.origin.x, location.origin.y, location.size.width,location.size.height);

    
    return attr;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind atIndexPath:(NSIndexPath *)indexPath
{
    TFLog(@"Inside layoutAttributesForDecorationViewOfKind");
    
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    
    TFLog(@"Frame: %@", NSStringFromCGRect(self.collectionView.frame));
    
    float zoomScale = self.collectionView.zoomScale;
    
    if (zoomScale < 1)
    {
        zoomScale = 1;
    }
    
    attr.frame = CGRectMake(0, 0, self.collectionView.frame.size.width*zoomScale, self.collectionView.frame.size.height*zoomScale);
    
    attr.zIndex = -1;
    
    
    return attr;
}



-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    TFLog(@"Inside layoutAttributesForElementsInRect");

    
    UICollectionViewLayoutAttributes *background = [self layoutAttributesForDecorationViewOfKind:@"Background" atIndexPath:nil];


    return @[ [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]], background];
}







@end
