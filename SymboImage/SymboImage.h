//
//  SymboImageAsset.h
//  SymboImage
//
//  Created by YLCHUN on 2020/11/18.
//

/// name.siasset
/// SymboImageRawFile/files

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SymboImageProvider : NSObject
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) UIColor *color;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) id data; // file, data, string

@property (nonatomic, readonly, nonnull) UIImage *image;

- (UIImage *_Nullable)generateImage;
@end

@interface SymboFontImageProvider : SymboImageProvider
/// file 字体名称 与 字体文件名 一致
@property (nonatomic, copy) NSString *name; ///icon 对应编码
@end

NS_ASSUME_NONNULL_END
