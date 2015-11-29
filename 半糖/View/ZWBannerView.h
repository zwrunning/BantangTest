//
//  ZWBannerView.h
//  半糖
//
//  Created by Air. on 15/11/29.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWBannerView;

@protocol ZWBannerViewDelegate <NSObject>

- (void)cycleScrollView:(ZWBannerView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface ZWBannerView : UIView

/** 本地图片数组 */
@property (nonatomic, strong) NSArray *localizationImagesGroup;
/** 网络图片 url string 数组 */
@property (nonatomic, strong) NSArray *imageURLStringsGroup;
/** 每张图片对应要显示的文字数组 */
@property (nonatomic, strong) NSArray *titlesGroup;
/** 自动滚动间隔时间,默认2s */
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;
/** 是否无限循环,默认Yes */
@property(nonatomic,assign) BOOL infiniteLoop;
/** 是否自动滚动,默认Yes */
@property(nonatomic,assign) BOOL autoScroll;

@property (nonatomic, weak) id<ZWBannerViewDelegate> delegate;
/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;
/** 分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *dotColor;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imagesGroup:(NSArray *)imagesGroup;

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLStringsGroup:(NSArray *)imageURLStringsGroup;
@end
