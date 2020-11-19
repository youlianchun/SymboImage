//
//  SymboImageAsset.m
//  SymboImage
//
//  Created by YLCHUN on 2020/11/18.
//

#import "SymboImageAsset.h"
#import "SymboImageProvider.h"

@implementation SymboImageAsset
{
    NSBundle *_bundle;
}
+ (instancetype)assetWithNamed:(NSString *)name inBundle:(NSBundle *)bundle {
    NSDataAsset *asset = [[NSDataAsset alloc] initWithName:name bundle:bundle];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:asset.data options:NSJSONReadingAllowFragments error:NULL];
    SymboImageAsset *sia = [SymboImageAsset new];
    sia.height = [dict[@"height"] doubleValue];
    sia.width = [dict[@"width"] doubleValue];
    sia.type = [dict[@"type"] intValue];
    NSArray *confs = dict[@"configs"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *conf in confs) {
        SymboImageConfig *sic = [SymboImageConfig new];
        sic.file = conf[@"file"];
        sic.name = conf[@"name"];
        sic.type = conf[@"type"];
        sic.rgba = conf[@"rgba"];
        sic.color = si_colorFromHexString(sic.rgba);
        [arr addObject:sic];
    }
    sia.configs = [arr copy];
    return sia;
}

- (SymboImageConfig *)confWithType:(SymboImageConfigType)type {
    if (self.configs.count < 2) {
        return self.configs.firstObject;
    }
    else {
        for (SymboImageConfig *config in self.configs) {
            if ([config.type isEqual:type]) {
                return config;
            }
        }
    }
    return nil;
}

- (UIImage *)imageWithConfigType:(SymboImageConfigType)type {
    SymboFontImageProvider *si = [SymboFontImageProvider new];
    si.width = self.width;
    si.height = self.height;
    SymboImageConfig *config = [self confWithType:type];
    si.data = [[NSDataAsset alloc] initWithName:config.file bundle:_bundle].data;
    si.name = config.name;
    si.color = config.color;
    return si.image;
}

static UIColor *si_colorFromHexString(NSString *hexStr) {
    ///"#RRGGBBAA"
    NSString *rgbStr = [hexStr substringWithRange:NSMakeRange(1, 6)];
    unsigned hex = 0, alpha = 0xFF;
    if(![[NSScanner scannerWithString:rgbStr] scanHexInt:&hex]) return nil;
    if (hexStr.length >= 9) {
        NSString *aStr = [hexStr substringWithRange:NSMakeRange(7, 2)];
        [[NSScanner scannerWithString:aStr] scanHexInt:&alpha];
    }
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = hex & 0xFF;
    int a = alpha & 0xFF;
    return [UIColor colorWithRed:r /255.0f green:g /255.0f blue:b /255.0f alpha:a/255.0f];
}


@end
