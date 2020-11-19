//
//  SymboImageConfig.h
//  SymboImage
//
//  Created by YLCHUN on 2020/11/18.
//


#import <Foundation/Foundation.h>
@class UIColor;

typedef NSString * SymboImageConfigType;

NS_ASSUME_NONNULL_BEGIN

static const SymboImageConfigType SymboImageConfigType_light = @"light";
static const SymboImageConfigType SymboImageConfigType_dark = @"dark";

@interface SymboImageConfig : NSObject
@property (nonatomic, copy) SymboImageConfigType type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *file;
@property (nonatomic, copy) NSString *rgba;
@property (nonatomic, copy) UIColor *color;
@end

NS_ASSUME_NONNULL_END
