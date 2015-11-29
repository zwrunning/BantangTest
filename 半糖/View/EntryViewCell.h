//
//  EntryViewCell.h
//  半糖
//
//  Created by Air. on 15/11/29.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Entry;


@interface EntryViewCell : UICollectionViewCell

@property (nonatomic, strong) Entry *entry;
@property (nonatomic, strong) UIImageView *imageView;
@end
