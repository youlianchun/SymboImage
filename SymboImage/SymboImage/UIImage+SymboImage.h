//
//  UIImage+SymboImage.h
//  SymboImage
//
//  Created by YLCHUN on 2020/11/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SymboImage)
+ (UIImage * _Nullable)symboImageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

NS_ASSUME_NONNULL_END
