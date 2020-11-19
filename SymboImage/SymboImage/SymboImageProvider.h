//
//  SymboImageProvider.h
//  SymboImage
//
//  Created by YLCHUN on 2020/11/18.
//

/// name.siasset
/// SymboImageRawFile/files

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// width 或 height 为0 时自适应
@interface SymboImageProvider : NSObject
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat scale;
@property (nonatomic, strong) id data; /// file, data, string

@property (nonatomic, readonly, nonnull) UIImage *image;

- (UIImage *_Nullable)generateImage;

@end

@interface SymboFontImageProvider : SymboImageProvider
/// file 字体名称 与 字体文件名 一致
@property (nonatomic, copy) UIColor *color;
/// unicode 可用 FontExplorer_X 查看
@property (nonatomic, copy) NSString *name; /// unicode 字符串，不是unicode
@property (nonatomic, readonly) NSString *unicode;
@end

NS_ASSUME_NONNULL_END
