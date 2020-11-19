//
//  SymboImageAsset.h
//  SymboImage
//
//  Created by YLCHUN on 2020/11/18.
//

/// name.siasset
/// SymboImageRawFile/files

#import <UIKit/UIKit.h>
#import "SymboImageConfig.h"

typedef NS_ENUM(NSInteger, SymboImageType) {
    SymboImageType_SVG = 0,
    SymboImageType_Font
};

NS_ASSUME_NONNULL_BEGIN

@interface SymboImageAsset : NSObject
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) SymboImageType type;
@property (nonatomic, copy) NSArray<SymboImageConfig *> *configs;
+ (instancetype)assetWithNamed:(NSString *)name inBundle:(NSBundle *)bundle;
- (UIImage *)imageWithConfigType:(SymboImageConfigType)type;
@end

NS_ASSUME_NONNULL_END
