//
//  UIImage+SymboImage.m
//  SymboImage
//
//  Created by YLCHUN on 2020/11/19.
//

#import "UIImage+SymboImage.h"
#import "SymboImageAsset.h"
#import <ImageDynamicAsset/UIImage+ImageDynamicAsset.h>

@implementation UIImage (SymboImage)
+ (UIImage *)symboImageNamed:(NSString *)name inBundle:(NSBundle *)bundle {
    SymboImageAsset *sia = [SymboImageAsset assetWithNamed:name inBundle:bundle];
    return [UIImage imageWithDynamicProvider:^UIImage * _Nullable(UIUserInterfaceStyle style) {
        if (style == UIUserInterfaceStyleDark) {
            return [sia imageWithConfigType:SymboImageConfigType_dark];
        }
        else {
            return [sia imageWithConfigType:SymboImageConfigType_light];
        }
    }];
}
@end
