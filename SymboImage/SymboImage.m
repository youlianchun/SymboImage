//
//  SymboImage.m
//  SymboImage
//
//  Created by YLCHUN on 2020/11/18.
//

#import "SymboImageProvider.h"
#import <pthread/pthread.h>
#import <CoreText/CoreText.h>

static void si_syncToMainIfNeed(void(^block)(void)) {
    if (pthread_main_np()) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@implementation SymboImageProvider
@synthesize image = _image;

- (instancetype)init {
    self = [super init];
    si_syncToMainIfNeed(^{
        self.scale = UIScreen.mainScreen.scale;
    });
    return self;
}

- (UIImage *)image {
    if (!_image) {
        _image = [self generateImage];
    }
    return _image;
}

- (UIImage *_Nullable)generateImage {
    return nil;
}

@end


@implementation SymboFontImageProvider

- (UIImage *_Nullable)generateImage {
    if (self.width == 0 || self.height == 0) return nil;
    UIFont *utilFont = nil;
    if ([self.data isKindOfClass:[NSData class]]) {
        utilFont = si_fontFromData(10, self.data);
    }
    else if ([self.data isKindOfClass:[NSString class]]) {
        utilFont = si_fontFromPath(10, self.data);
    }
    
    if (!utilFont) return nil;
    
    CGSize utilSize = [self.name sizeWithAttributes:@{NSFontAttributeName:utilFont}];
    if (utilSize.width == 0 || utilSize.height == 0) return nil;
    
    CGSize size = CGSizeMake(self.width, self.height);
    size.width *= self.scale;
    size.height *= self.scale;
    
    CGSize fontSize = si_sizeAspectFit(utilSize, size);
    UIFont *font = [utilFont fontWithSize:fontSize.height / utilSize.height * utilFont.pointSize];
    
    CGPoint point = CGPointMake((size.width - fontSize.width) / 2.0, (size.height - fontSize.height) / 2.0);
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = font;
    attributes[NSForegroundColorAttributeName] = self.color;
    
    __block UIImage *image = nil;
    si_syncToMainIfNeed(^{
        UIGraphicsBeginImageContext(size);
        [self.name drawAtPoint:point withAttributes:attributes];
        
        [[UIImage alloc] initWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:self.scale orientation:UIImageOrientationUp];
        image = [UIImage imageWithCGImage:UIGraphicsGetImageFromCurrentImageContext().CGImage scale:self.scale orientation:UIImageOrientationUp];
        UIGraphicsEndImageContext();
    });
    return image;
}

static UIFont *si_fontFromPath(CGFloat size, NSString *path) {
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (!data) return nil;
    return si_fontFromData(size, data);
}

static UIFont *si_fontFromData(CGFloat size, NSData *data) {
    UIFont *font = nil;
    do {
        CGDataProviderRef dataProvider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
        if (!dataProvider) {
            break;
        }
        
        CGFontRef graphicsFont = CGFontCreateWithDataProvider(dataProvider);
        CFRelease(dataProvider);
        if (!graphicsFont) {
            break;
        }
        
        CTFontRef smallFont = CTFontCreateWithGraphicsFont(graphicsFont, size, NULL, NULL);
        CFRelease(graphicsFont);
        if (!smallFont){
            break;
        }
        
        font = (__bridge UIFont *)smallFont;
        CFRelease(smallFont);

    } while(0);
    
    return font;
}

static CGSize si_sizeAspectFit(CGSize size, CGSize inSize) {
    CGSize newSize = inSize;
    BOOL nonZero = (size.width > 0 && size.height > 0) && (inSize.width > 0 && inSize.height > 0);
    if (nonZero) {
        CGFloat ratio = size.width / size.height;
        CGFloat inRatio = inSize.width / inSize.height;
        if (inRatio > ratio) {
            CGFloat width = inSize.height * size.width / size.height;
            newSize.width = width;
        } else {
            CGFloat height = inSize.width * size.height / size.width;
            newSize.height = height;
        }
    }
    return newSize;
}

@end
