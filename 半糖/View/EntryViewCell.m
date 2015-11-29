//
//  EntryViewCell.m
//  半糖
//
//  Created by Air. on 15/11/29.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "EntryViewCell.h"
#import "Entry.h"

@implementation EntryViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        [self addSubview:_imageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.contentView.bounds;
}

- (void)setEntry:(Entry *)entry {
    _entry = entry;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:entry.pic1]];
}
@end
